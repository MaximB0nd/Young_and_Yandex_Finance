//
//  BankAccountDataBackupModel.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 22.07.2025.
//

import Foundation
import SwiftData

enum BankAccountAction: Codable {
    case localUpdate
    case remoteUpdate
}

@Model
final class BankAccountDataBackupModel {
    
    @Attribute(.unique)
    var idOfAction = UUID()
    var dateOfAction = Date()
    
    var id: Int
    var userId: Int
    var name: String
    var balance: Decimal
    var currency: String
    var createdAt: Date
    var updatedAt: Date
    
    var action: BankAccountAction
    
    init(from bankAccount: BankAccount, action: BankAccountAction) {
        self.id = bankAccount.id
        self.userId = bankAccount.userId
        self.name = bankAccount.name
        self.balance = bankAccount.balance
        self.currency = bankAccount.currency
        self.createdAt = bankAccount.createdAt
        self.updatedAt = bankAccount.updatedAt
        self.action = action
    }
    
    var bankAccount: BankAccount {
        BankAccount(
            id: id,
            userId: userId,
            name: name,
            balance: balance,
            currency: currency,
            createdAt: createdAt,
            updatedAt: updatedAt)
    }
}
