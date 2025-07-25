//
//  Transaction.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 12.06.2025.
//

import Foundation

struct Transaction: Identifiable {
    let id: Int
    var account: Transaction.Account
    var category: Category
    var amount: Decimal
    var transactionDate: Date
    var comment: String?
    let createdAt: Date
    var updatedAt: Date
    
    init(id: Int, account: Transaction.Account, category: Category, amount: Decimal, transactionDate: Date, comment: String? = nil, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.account = account
        self.category = category
        self.amount = amount
        self.transactionDate = transactionDate
        self.comment = comment
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    init(from transaction: NetworkClient.TransactionForResponse) {
        self.id = transaction.id
        self.account = .init(id: transaction.accountId, name: "", balance: 0, currency: "")
        self.category = .init(id: transaction.accountId, name: "", emoji: "@", direction: .income)
        self.amount = transaction.amount
        self.comment = transaction.comment
        self.transactionDate = transaction.transactionDate
        self.createdAt = transaction.createdAt
        self.updatedAt = transaction.updatedAt
    }
}
