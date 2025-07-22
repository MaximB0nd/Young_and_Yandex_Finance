//
//  CategoryDataModel.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 22.07.2025.
//

import Foundation
import SwiftData

@Model
final class CategoryDataModel {
    var id: Int
    var name: String
    var emoji: String
    var direction: Direction
    
    init(id: Int, name: String, emoji: Character, direction: Direction) {
        self.id = id
        self.name = name
        self.emoji = String(emoji)
        self.direction = direction
    }
    
    init(from category: Category) {
        self.id = category.id
        self.name = category.name
        self.emoji = String(category.emoji)
        self.direction = category.direction
    }
    
    var category: Category {
        Category(
            id: id,
            name: name,
            emoji: emoji.first ?? " ",
            direction: direction)
    }
}
