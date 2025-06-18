//
//  Category+Codable.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 18.06.2025.
//

import Foundation

extension Category: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case id, name, emoji, isIncome
    }
    
    init(from decoder: any Decoder) throws {
        let containet = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try containet.decode(Int.self, forKey: .id)
        self.name = try containet.decode(String.self, forKey: .name)
        let emoji = try containet.decode(String.self, forKey: .emoji)
        self.emoji = emoji.first ?? " "
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
