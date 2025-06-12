//
//  BankAccount.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 12.06.2025.
//

import Foundation

struct BankAccount {
    let id: Int
    let userId: Int
    var name: String
    var balance: Decimal
    var currency: Currency
    let createdAt: Date
    var updatedAt: Date
}
