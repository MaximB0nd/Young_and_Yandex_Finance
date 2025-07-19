//
//  TransactionSwiftDataBackupModel.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 19.07.2025.
//

import Foundation
import SwiftData

enum Actions: Codable {
    case create
    case update
    case delete
}

@Model
final class TransactionDataBackupModel {
    @Attribute(.unique)
    var idOfAction = UUID()
    
    var id: Int
    
    var account: AccountDataModel
 
    var category: CategoryDataModel
    
    var amount: Decimal
    var transactionDate: Date
    var comment: String?
    var createdAt: Date
    var updatedAt: Date
    
    var action: Actions
    
    init(transaction: Transaction, action: Actions) {
        self.id = transaction.id
        self.account = .init(account: transaction.account)
        self.category = .init(category: transaction.category)
        self.amount = transaction.amount
        self.transactionDate = transaction.transactionDate
        self.comment = transaction.comment
        self.createdAt = transaction.createdAt
        self.updatedAt = transaction.updatedAt
        self.action = action
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
final class CategoryDataBackupModel {
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
final class AccountDataBackupModel {
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
