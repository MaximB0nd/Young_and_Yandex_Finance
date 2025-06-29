//
//  BankAccount+Equatable.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 27.06.2025.
//

import Foundation

extension BankAccount: Equatable {
    static func == (lhs: BankAccount, rhs: BankAccount) -> Bool {
        lhs.id == rhs.id
        && lhs.updatedAt == rhs.updatedAt
        && lhs.currency.lowercased() == rhs.currency.lowercased()
        && lhs.balance == rhs.balance
        && lhs.name == rhs.name
        && lhs.createdAt == rhs.createdAt
        && lhs.userId == rhs.userId
        && lhs.name == rhs.name
    }
}
