//
//  BankAccountModel.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 20.07.2025.
//

import Foundation
import SwiftData

@Model
final class BankAccountModel {
    var id: Int
    var userId: Int
    var name: String
    var balance: Decimal
    var currency: String
    var createdAt: Date
    var updatedAt: Date
    
    init(id: Int, userId: Int, name: String, balance: Decimal, currency: String, createdAt: Date, updatedAt: Date) {
        self.id = id
        self.userId = userId
        self.name = name
        self.balance = balance
        self.currency = currency
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
    
    init(from bankAccount: BankAccount){
        self.id = bankAccount.id
        self.userId = bankAccount.userId
        self.name = bankAccount.name
        self.balance = bankAccount.balance
        self.currency = bankAccount.currency
        self.createdAt = bankAccount.createdAt
        self.updatedAt = bankAccount.updatedAt
    }
    
    var bankAccount: BankAccount {
        BankAccount(id: id, userId: userId, name: name, balance: balance, currency: currency, createdAt: createdAt, updatedAt: updatedAt)
    }
}
