//
//  TransactionsService.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 12.06.2025.
//

import Foundation

struct TransactionListner {
    weak var listner: TransactionListnerProtocol?
}

@Observable
final class TransactionsService{
    
    private static var _subscribers: [TransactionListner] = []
    
    private enum TransactionError: Error {
        case notFound
        case enotherError(code: Int, message: String)
    }
    
    static var shared = TransactionsService()
    
    private(set) var _transactions: [Transaction]
    private let cacher: CacheSaver = TransactionsSwiftDataCache.shared
    
    private let client = NetworkClient()
    
    private init () {
        do {
            try cacher.load()
        } catch {
            _transactions = []
        }
        _transactions = cacher.transactions
    }
    
    // Делаем loadTransactions асинхронным и возвращающим результат только после загрузки
    func loadTransactions() async throws {
        do {
            self._transactions = try await client.transaction.request(by: BankAccountsService.id)
        } catch (let error) {
            try? cacher.load()
            _transactions = cacher.transactions
            throw error
        }
    }
    
    func getTransactions(from: Date, to: Date) async -> ResponceResult<[Transaction], Error> {
        
        var result = ResponceResult<[Transaction], Error>()
        do {
            try await loadTransactions()
        } catch {
            result.error = error
        }
    
        result.success = self._transactions.filter({$0.transactionDate >= from && $0.transactionDate <= to})
        
        return result
        
    }
    
    //MARK: - добавь реализацию с ошибками и сохранением в бэкап
    
    func createTransaction(account: Transaction.Account, category: Category, amount: Decimal, transactionDate: Date, comment: String? = nil) async {
        try? await loadTransactions()
        let newId = (_transactions.map { $0.id }.max() ?? -1) + 1
        let newTransaction = Transaction(id: newId,
                                         account: account,
                                         category: category,
                                         amount: amount,
                                         transactionDate: transactionDate,
                                         comment: comment == "" ? nil : comment,
                                         createdAt: .now,
                                         updatedAt: .now)
        self._transactions.append(newTransaction)
        cacher.add(newTransaction)
        try? cacher.save()
        await notifySubscribers()
    }
    
    func editTransaction(id: Int, newCategory: Category? = nil, newAmount: Decimal? = nil, newTransactionDate: Date? = nil, newComment: String? = nil) async throws {
        try await loadTransactions()
        guard let index = _transactions.firstIndex(where: { $0.id == id}) else {
            throw TransactionError.notFound
        }
        guard newAmount != nil || newTransactionDate != nil || newCategory != nil || newCategory != nil || newComment != nil else { return }
        if let newCategory = newCategory {
            _transactions[index].category = newCategory
        }
        if let newAmount = newAmount {
            _transactions[index].amount = newAmount
        }
        if let newTransactionDate = newTransactionDate {
            _transactions[index].transactionDate = newTransactionDate
        }
        if let newComment = newComment {
            if newComment == "" {
                _transactions[index].comment=nil
            } else {
                _transactions[index].comment = newComment
            }
        }
        _transactions[index].updatedAt = Date.now
        
        cacher.delete(id: id)
        cacher.add(_transactions[index])
        try cacher.save()
        await notifySubscribers()
    }
    
    func deleteTransaction(id: Int) async throws {
        try await loadTransactions()
        guard let index = _transactions.firstIndex(where: { $0.id == id }) else {
            throw TransactionError.notFound
        }
        _transactions.remove(at: index)
        cacher.delete(id: id)
        try cacher.save()
        await notifySubscribers()
    }
    
    static func subscribe(listener: TransactionListnerProtocol) {
        _subscribers.append(TransactionListner(listner: listener))
    }
    
    func notifySubscribers() async {
        for subscriber in Self._subscribers {
            await subscriber.listner?.updateTransactions()
        }
    }
}
