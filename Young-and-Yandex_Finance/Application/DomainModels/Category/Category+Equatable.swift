//
//  Category+Equatable.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 20.06.2025.
//

import Foundation

extension Category: Equatable {
    public static func == (lhs: Category, rhs: Category) -> Bool {
        lhs.id == rhs.id
        && lhs.direction == rhs.direction
        && lhs.name == rhs.name
        && lhs.emoji == rhs.emoji
    }
}
