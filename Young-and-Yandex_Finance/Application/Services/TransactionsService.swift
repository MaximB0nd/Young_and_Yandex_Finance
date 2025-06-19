//
//  TransactionsService.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 12.06.2025.
//

import Foundation

enum TransactionError: Error {
    case notFound
    case enotherError(code: Int, message: String)
}

final class TransactionsService: ObservableObject {
    
    @Published private var _transactions: [Transaction]
    
    let transactionFileCache = TransactionsFileCache()
    let filePath = "Y&Y_Finance-transactions.json"
    
    init () {
        do {
            try transactionFileCache.load(paths: filePath)
        } catch {
            _transactions = []
        }
        _transactions = transactionFileCache.transactions
    }
    
    func getTransactions(from: Date, to: Date) async -> [Transaction] {
        return _transactions.filter({$0.transactionDate >= from && $0.transactionDate <= to})
    }
    
    func createTransaction(account: Transaction.Account, category: Category, amount: Decimal, transactionDate: Date, comment: String? = nil) async throws {
        let newId = (_transactions.map { $0.id }.max() ?? -1) + 1
        let newTransaction = Transaction(id: newId,
                                         account: account,
                                         category: category,
                                         amount: amount,
                                         transactionDate: transactionDate,
                                         comment: comment,
                                         createdAt: .now,
                                         updatedAt: .now)
        _transactions.append(newTransaction)
        transactionFileCache.add(newTransaction)
        try transactionFileCache.save(fileName: filePath)
    }
    
    func editTransaction(id: Int, newCategory: Category? = nil, newAmount: Decimal? = nil, newTransactionDate: Date? = nil, newComment: String? = nil) async throws {
        
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
            if newComment=="" {
                _transactions[index].comment=nil
            } else {
                _transactions[index].comment = newComment
            }
        }
        _transactions[index].updatedAt = Date.now
        
        transactionFileCache.delete(id: id)
        transactionFileCache.add(_transactions[index])
        try transactionFileCache.save(fileName: filePath)
    }
    
    func deleteTransaction(id: Int) async throws {
        guard let index = _transactions.firstIndex(where: { $0.id == id }) else {
            throw TransactionError.notFound
        }
        _transactions.remove(at: index)
    }
}
