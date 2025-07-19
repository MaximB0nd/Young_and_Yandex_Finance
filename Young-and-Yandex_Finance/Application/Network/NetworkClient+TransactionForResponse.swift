//
//  NetworkClient+TransactionForResponse.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 17.07.2025.
//

import Foundation

extension NetworkClient {
    struct TransactionForResponse: Decodable {
        let id: Int
        let accountId: Int
        let categoryId: Int
        let amount: Decimal
        let transactionDate: Date
        let comment: String?
        let createdAt: Date
        let updatedAt: Date
        
        private enum CodingKeys: String, CodingKey {
            case id, accountId, categoryId, amount, transactionDate, comment, createdAt, updatedAt
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
            self.accountId = try container.decode(Int.self, forKey: .accountId)
            self.categoryId = try container.decode(Int.self, forKey: .categoryId)
            let amount = try container.decode(String.self, forKey: .amount)
            self.amount = Decimal(string: amount)!
            self.comment = try container.decode(String?.self, forKey: .comment)
            
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
        
    }
    
    
}
