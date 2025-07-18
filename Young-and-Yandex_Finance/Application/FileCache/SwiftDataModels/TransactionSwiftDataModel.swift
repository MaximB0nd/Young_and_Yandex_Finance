//
//  TransactionSwiftDataModel.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 18.07.2025.
//

import Foundation
import SwiftData

@Model
final class TransactionSwiftDataModel {
    var id: Int
    var account: AccountSwiftDataModel
    var category: CategorySwiftDataModel
    var amount: Decimal
    var transactionDate: Date
    var comment: String?
    var createdAt: Date
    var updatedAt: Date
    
    init(transaction: Transaction) {
        self.id = transaction.id
        self.account = .init(account: transaction.account)
        self.category = .init(category: transaction.category)
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
                id: account.id,
                name: account.name,
                balance: account.balance,
                currency: account.currency),
            category: .init(
                id: category.id,
                name: category.name,
                emoji: category.emoji.first!,
                direction: category.direction),
            amount: amount,
            transactionDate: transactionDate,
            createdAt: createdAt,
            updatedAt: updatedAt)
    }
}

@Model
final class CategorySwiftDataModel {
    var id: Int
    var name: String
    var emoji: String
    var direction: Direction
    
    init(category: Category) {
        self.id = category.id
        self.name = category.name
        self.emoji = String(category.emoji)
        self.direction = category.direction
    }
}

@Model
final class AccountSwiftDataModel {
    var id: Int
    var name: String
    var balance: Decimal
    var currency: String
    
    init(account: Transaction.Account) {
        self.id = account.id
        self.name = account.name
        self.balance = account.balance
        self.currency = account.currency
    }
}
