//
//  Transaction.Account+Equatable.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 18.07.2025.
//

import Foundation

extension Transaction.Account: Equatable {
    static func == (lhs: Transaction.Account, rhs: Transaction.Account) -> Bool {
        lhs.id == rhs.id
        && lhs.name == rhs.name
        && lhs.balance == rhs.balance
        && lhs.currency == rhs.currency
    }
}
