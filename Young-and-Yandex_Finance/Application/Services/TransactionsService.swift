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
    
    private(set) var _transactions: [Transaction] = []
    private let cacher: CacheSaver = TransactionsFileCache.shared
    
    private let client = NetworkClient()
    private let backup = TransactionsBackup.shared
    var error: Error?
    
    private init () {
        Task {
            await loadTransactions()
        }
    }
    
    // Делаем loadTransactions асинхронным и возвращающим результат только после загрузки
    func loadTransactions() async -> [Transaction] {
        await tryRequestToClient()
        do {
            self._transactions = try await client.transaction.request(by: BankAccountsService.id)
            try cacher.rewrite(self._transactions)
            return _transactions
        } catch (let error) {
            try? cacher.load()
            _transactions = cacher.transactions
            
            ErrorLabelProvider.shared.showErrorLabel(with: error.localizedDescription)
            
            let noSyncedTransactions = await backup.getAllNotSynced()
            
            let merged = await mergeBackup(with: noSyncedTransactions)
            
            return merged
        }
    }
    
    func tryRequestToClient() async {
        for transaction in await backup.getAllNotSynced() {
            switch transaction.action {
            case .create:
                do {
                    let newTransaction = try await client.transaction.request(newTransaction: .init(from: transaction.transaction.transaction))
                    
                    self._transactions.append(newTransaction)
                    self.cacher.add(newTransaction)
                    try self.cacher.save()
                    
                    backup.delete(transaction.transaction.transaction, action: transaction.action)
                    
                } catch {}
            case .update:
                do {
                    let newEdit = try await client.transaction.request(newTransaction: .init(from: transaction.transaction.transaction), by: transaction.transaction.transaction.id)
                    
                    self._transactions.removeAll {$0.id == newEdit.id}
                    self._transactions.append(newEdit)
                    self.cacher.delete(id: newEdit.id)
                    self.cacher.add(newEdit)
                    try self.cacher.save()
                    
                    backup.delete(transaction.transaction.transaction, action: transaction.action)
                   
                    
                } catch {}
                
            case .delete:
                do {
                    let _: Void = try await client.transaction.request(by: transaction.transaction.id)
                    
                    self._transactions.removeAll {$0.id == transaction.transaction.transaction.id }
                    self.cacher.delete(id: transaction.transaction.transaction.id)
                    try self.cacher.save()
                    
                    backup.delete(transaction.transaction.transaction, action: transaction.action)
                    
                } catch {}
            }
        }
    }
    
    func mergeBackup(with transactions: [TransactionBackupSwiftDataModel]) async -> [Transaction] {
        
        var allTransactions = _transactions
        
        for transaction in transactions {
            switch transaction.action {
            case .create:
                allTransactions.append(transaction.transaction.transaction)
            case .delete:
                allTransactions.removeAll { $0.id == transaction.transaction.transaction.id }
            case .update:
                allTransactions.removeAll { $0.id == transaction.transaction.transaction.id }
                allTransactions.append(transaction.transaction.transaction)
            }
        }
        return allTransactions
    }
    
    func getTransactions(from: Date, to: Date) async -> ResponceResult<[Transaction], Error> {
        
        var result = ResponceResult<[Transaction], Error>()
        let allTransactions = await loadTransactions()
    
        result.success = allTransactions.filter({$0.transactionDate >= from && $0.transactionDate <= to})
        
        return result
    }
    
    
    func createTransaction(account: Transaction.Account, category: Category, amount: Decimal, transactionDate: Date, comment: String? = nil) async {
        do {
            let newTransaction = try await client.transaction.request(newTransaction: .init(accountId: account.id, categoryId: category.id, amount: amount, transactionDate: transactionDate, comment: comment))
            
            self._transactions.append(newTransaction)
            self.cacher.add(newTransaction)
            try self.cacher.save()
            
        } catch {
            let allTransactions = await loadTransactions()
            let newId = (allTransactions.map(\.id).max() ?? -1) + 1
            backup.add(Transaction(id: newId, account: account, category: category, amount: amount, transactionDate: transactionDate, comment: comment, createdAt: Date(), updatedAt: Date()), action: .create)
        }
        
        await notifySubscribers()
    }
    
    func editTransaction(id: Int, newCategory: Category? = nil, newAmount: Decimal? = nil, newTransactionDate: Date? = nil, newComment: String? = nil) async throws {
    
        do {
            guard let index = _transactions.firstIndex(where: { $0.id == id}) else {
                throw TransactionError.notFound
            }
            let newEdit = try await client.transaction.request(newTransaction:
                    .init(accountId: _transactions[index].account.id,
                          categoryId: newCategory?.id ?? _transactions[index].category.id,
                          amount: newAmount ?? _transactions[index].amount,
                          transactionDate: newTransactionDate ?? _transactions[index].transactionDate,
                          comment: newComment ?? _transactions[index].comment),
                        by: id)
            self.cacher.delete(id: _transactions[index].id)
            self._transactions[index] = newEdit
            self.cacher.add(newEdit)
            try self.cacher.save()
            
        } catch {
            let allTransactions = await loadTransactions()
            guard let index = allTransactions.firstIndex(where: { $0.id == id }) else {
                throw TransactionError.notFound
            }
            
            let updated = Transaction(
                id: id,
                account: allTransactions[index].account,
                category: newCategory ?? allTransactions[index].category,
                amount: newAmount ?? allTransactions[index].amount,
                transactionDate: newTransactionDate ?? allTransactions[index].transactionDate,
                createdAt: allTransactions[index].createdAt,
                updatedAt: Date())
            
            backup.add(updated, action: .update)
        }
        
        await notifySubscribers()
    }
    
    func deleteTransaction(id: Int) async throws {
        
        do {
            guard let index = _transactions.firstIndex(where: { $0.id == id }) else {
                throw TransactionError.notFound
            }
            let _: Void = try await client.transaction.request(by: _transactions[index].id)
            self.cacher.delete(id: _transactions[index].id)
            self._transactions.remove(at: index)
            try self.cacher.save()
            
        } catch {
            let allTransactions = await loadTransactions()
            guard let index = allTransactions.firstIndex(where: { $0.id == id }) else {
                throw TransactionError.notFound
            }
            backup.add(_transactions[index] , action: .delete)
        }
        
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
