//
//  TransactionDataModel.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 18.07.2025.
//

import Foundation
import SwiftData

@Model
final class TransactionDataModel {
    
    @Attribute(.unique)
    var id: Int
    
    var categoryId: Int
    var categoryName: String
    var categoryEmoji: String
    var categoryDirection: Direction
    
    var accountId: Int
    var accountName: String
    var accountBalance: Decimal
    var accountCurrency: String
    
    var amount: Decimal
    var transactionDate: Date
    var comment: String?
    var createdAt: Date
    var updatedAt: Date

    init(transaction: Transaction) {
        self.id = transaction.id
    
        self.accountId = transaction.account.id
        self.accountName = transaction.account.name
        self.accountBalance = transaction.account.balance
        self.accountCurrency = transaction.account.currency

        self.categoryId = transaction.category.id
        self.categoryName = transaction.category.name
        self.categoryEmoji = String(transaction.category.emoji)
        self.categoryDirection = transaction.category.direction

        self.amount = transaction.amount
        self.transactionDate = transaction.transactionDate
        self.comment = transaction.comment
        self.createdAt = transaction.createdAt
        self.updatedAt = transaction.updatedAt
    }

    var transaction: Transaction {
        Transaction(
            id: id,
            account: .init(
                id: accountId,
                name: accountName,
                balance: accountBalance,
                currency: accountCurrency),
            category: .init(
                id: categoryId,
                name: categoryName,
                emoji: categoryEmoji.first ?? "?",
                direction: categoryDirection),
            amount: amount,
            transactionDate: transactionDate,
            createdAt: createdAt,
            updatedAt: updatedAt)
    }
}

