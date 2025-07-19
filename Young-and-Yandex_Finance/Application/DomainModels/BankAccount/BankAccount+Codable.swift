//
//  BankAccount+Codable.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 16.07.2025.
//

import Foundation

extension BankAccount {
    
    private enum CodingKeys: String, CodingKey {
        case id, userId, name, balance, currency, createdAt, updatedAt
    }
    
    init(from decoder: any Decoder) throws {
        let isoDateFormatterWithSec = ISO8601DateFormatter()
        isoDateFormatterWithSec.formatOptions = [
            .withInternetDateTime,
            .withTimeZone,
            .withFractionalSeconds
        ]
        
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [
            .withInternetDateTime,
            .withTimeZone
        ]
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(Int.self, forKey: .id)
        self.userId = try container.decode(Int.self, forKey: .userId)
        self.name = try container.decode(String.self, forKey: .name)
        let balance = try container.decode(String.self, forKey: .balance)
        self.balance = Decimal(string: balance)!
        self.currency = try container.decode(String.self, forKey: .currency)
        let createdAt = try container.decode(String.self, forKey: .createdAt)
        let updatedAt = try container.decode(String.self, forKey: .updatedAt)
        
        if let date = isoDateFormatterWithSec.date(from: createdAt) {
            self.createdAt = date
        } else {
            self.createdAt = isoDateFormatter.date(from: createdAt)!
        }
        
        if let date = isoDateFormatterWithSec.date(from: updatedAt) {
            self.updatedAt = date
        } else {
            self.updatedAt = isoDateFormatter.date(from: updatedAt)!
        }
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(userId, forKey: .userId)
        try container.encode(name, forKey: .name)
        try container.encode(balance, forKey: .balance)
        try container.encode(currency, forKey: .currency)
        try container.encode(createdAt, forKey: .createdAt)
        try container.encode(updatedAt, forKey: .updatedAt)
    }
}
