//
//  Transaction+Equatable.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 20.06.2025.
//

import Foundation

extension Transaction: Equatable {
    public static func == (lhs: Transaction, rhs: Transaction) -> Bool {
        lhs.id == rhs.id
        && lhs.updatedAt == rhs.updatedAt
    }
}
