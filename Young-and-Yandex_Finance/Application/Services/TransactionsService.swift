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

final class TransactionsService {
    private var _transactions: [Transaction]
    
    init () {
        var transactions = [Transaction]()
        for i in 0..<100 {
            transactions.append(.init(id: i, accountId: i, categoryId: i, amount: Decimal(i*100), transactionDate: Date.now, createdAt: Date.now, updatedAt: Date.now))
        }
        _transactions = transactions
    }
    
    func getTransactions(from: Date, to: Date) async -> [Transaction] {
        return _transactions.filter({$0.transactionDate >= from && $0.transactionDate <= to})
    }
    
    func createTransaction(accountId: Int, categoryId: Int, amount: Decimal, transactionDate: Date) async {
        let newId = (_transactions.max(by: { $0.id < $1.id })?.id ?? 0) + 1
        _transactions.append(.init(id: newId, accountId: accountId, categoryId: categoryId, amount: amount, transactionDate: transactionDate, createdAt: Date.now, updatedAt: Date.now))
    }
    
    func editTransaction(id: Int, accountId: Int, categoryId: Int, newAmount: Decimal=0, newTransactionDate: Date = .now) async throws {
        guard let index = _transactions.firstIndex(where: { $0.id == id}) else {
            throw TransactionError.notFound
        }
        guard newAmount != 0 || newTransactionDate != .now else { return }
        _transactions[index].amount = newAmount
        _transactions[index].transactionDate = newTransactionDate
        _transactions[index].updatedAt = Date.now
    }
    
    func deleteTransaction(id: Int) async throws {
        guard let index = _transactions.firstIndex(where: { $0.id == id }) else {
            throw TransactionError.notFound
        }
        _transactions.remove(at: index)
    }
}
