//
//  Category.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 12.06.2025.
//

import Foundation

struct Category: Codable {
    let id: Int
    let name: String
    let emoji: Character
    let direction: Direction
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case emoji
        case isIncome
    }
    
    init(id: Int, name: String, emoji: Character, direction: Direction) {
        self.id = id
        self.name = name
        self.emoji = emoji
        self.direction = direction
    }
    
    init(from decoder: any Decoder) throws {
        let containet = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try containet.decode(Int.self, forKey: .id)
        self.name = try containet.decode(String.self, forKey: .name)
        let emoji = try containet.decode(String.self, forKey: .emoji)
        self.emoji = emoji.first!
        let income = try containet.decode(Bool.self, forKey: .isIncome)
        self.direction = income ? .income : .outcome
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(String(emoji), forKey: .emoji)
        try container.encode(direction == .income, forKey: .isIncome)
    }
}
