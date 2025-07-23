//
//  Transaction-Codable.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 13.06.2025.
//

import Foundation

extension Transaction: Codable {
    
    private enum CodingKeys: String, CodingKey {
        case id, account, category, amount, transactionDate, comment, createdAt, updatedAt
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
        self.account = try container.decode(Account.self, forKey: .account)
        self.category = try container.decode(Category.self, forKey: .category)
        let amount = try container.decode(String.self, forKey: .amount)
        self.amount = Decimal(string: amount)!
        
        let comment = try container.decode(String?.self, forKey: .comment)
        self.comment = comment != "" ? comment : nil
        
        let transactionDate = try container.decode(String.self, forKey: .transactionDate)
        let createdAt = try container.decode(String.self, forKey: .createdAt)
        let updatedAt = try container.decode(String.self, forKey: .updatedAt)
        
        if let date = isoDateFormatterWithSec.date(from: transactionDate) {
            self.transactionDate = date
        } else {
            self.transactionDate = isoDateFormatter.date(from: transactionDate)!
        }
        
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
        
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [
            .withInternetDateTime,
            .withTimeZone,
            .withFractionalSeconds
        ]
        
        try container.encode(id, forKey: .id)
        try container.encode(account, forKey: .account)
        try container.encode(category, forKey: .category)
        let amount = "\(self.amount)"
        try container.encode(amount, forKey: .amount)
        try container.encode(comment, forKey: .comment)
        try container.encode(isoDateFormatter.string(from: transactionDate), forKey: .transactionDate)
        try container.encode(isoDateFormatter.string(from: createdAt), forKey: .createdAt)
        try container.encode(isoDateFormatter.string(from: updatedAt), forKey: .updatedAt)
        
    }
    
    
}
