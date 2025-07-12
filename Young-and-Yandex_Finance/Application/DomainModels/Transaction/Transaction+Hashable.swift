//
//  Transaction+Hashable.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 11.07.2025.
//

import Foundation

extension Transaction: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(account.id)
        hasher.combine(category.id)
    }
}
