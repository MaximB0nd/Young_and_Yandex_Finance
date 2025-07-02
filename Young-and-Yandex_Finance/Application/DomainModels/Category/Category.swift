//
//  Category.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 12.06.2025.
//

import Foundation

struct Category: Identifiable {
    let id: Int
    let name: String
    let emoji: Character
    let direction: Direction
    
    init(id: Int, name: String, emoji: Character, direction: Direction) {
        self.id = id
        self.name = name
        self.emoji = emoji
        self.direction = direction
    }
}
