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
//        for i in 0..<100 {
//            transactions.append(.init(id: i, account: .init(id: i), category: .init(id: i), amount: <#T##String#>, transactionDate: <#T##String#>, comment: <#T##String#>, createdAt: <#T##String#>, updatedAt: <#T##String#>))
//        }
        _transactions = transactions
    }
    
//    func getTransactions(from: Date, to: Date) async -> [Transaction] {
//        return _transactions.filter({$0.transactionDate >= from && $0.transactionDate <= to})
//    }
    
    func createTransaction(accountId: Int, categoryId: Int, amount: Decimal, transactionDate: Date) async {
//        let newId = (_transactions.map { $0.id }.max() ?? -1) + 1
//        _transactions.append(.init(id: newId, account: .init(id: accountId), category: .init(id: categoryId), amount: amount, transactionDate: transactionDate, createdAt: .now, updatedAt: .now))
    }
    
    func editTransaction(id: Int, accountId: Int, categoryId: Int, newAmount: Decimal=0, newTransactionDate: Date = .now) async throws {
        guard let index = _transactions.firstIndex(where: { $0.id == id}) else {
            throw TransactionError.notFound
        }
        guard newAmount != 0 || newTransactionDate != .now else { return }
//        _transactions[index].amount = newAmount
//        _transactions[index].transactionDate = newTransactionDate
//        _transactions[index].updatedAt = Date.now
    }
    
    func deleteTransaction(id: Int) async throws {
        guard let index = _transactions.firstIndex(where: { $0.id == id }) else {
            throw TransactionError.notFound
        }
        _transactions.remove(at: index)
    }
}
