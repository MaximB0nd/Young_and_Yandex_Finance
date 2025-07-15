//
//  Category+Hashable.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 11.07.2025.
//

import Foundation

extension Category: Hashable {
    static func == (lhs: Category, rhs: Category) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
