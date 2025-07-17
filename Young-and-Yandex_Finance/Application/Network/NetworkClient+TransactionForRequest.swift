//
//  NetworkClient+TransactionForRequest.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 16.07.2025.
//

import Foundation

extension NetworkClient {
    struct TransactionForRequest: Encodable {
        let accountId: Int
        let categoryId: Int
        let amount: Decimal
        let transactionDate: Date
        let comment: String?
        
        init(from transaction: Transaction) {
            self.accountId = transaction.account.id
            self.amount = transaction.amount
            self.categoryId = transaction.category.id
            self.comment = transaction.comment
            self.transactionDate = transaction.transactionDate
        }
        
        init(accountId: Int, categoryId: Int, amount: Decimal, transactionDate: Date, comment: String?) {
            self.accountId = accountId
            self.amount = amount
            self.categoryId = categoryId
            self.comment = comment
            self.transactionDate = transactionDate
        }
        
        private enum CodingKeys: String, CodingKey {
            case accountId, categoryId, amount, transactionDate, comment
        }
        
        func encode(to encoder: any Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            let isoDateFormatter = ISO8601DateFormatter()
            isoDateFormatter.formatOptions = [
                .withInternetDateTime,
                .withTimeZone,
                .withFractionalSeconds
            ]
            
            try container.encode(accountId, forKey: .accountId)
            try container.encode(categoryId, forKey: .categoryId)
            let amount = "\(self.amount)"
            try container.encode(amount, forKey: .amount)
            try container.encode(comment, forKey: .comment)
            try container.encode(isoDateFormatter.string(from: transactionDate), forKey: .transactionDate)
        }
    }
}
