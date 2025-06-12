//
//  Transaction.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 12.06.2025.
//

import Foundation

struct Transaction {
    let id: Int
    let accountId: Int
    var categoryId: Int
    var amount: Decimal
    var transactionDate: Date
    var comment: String?
    let createdAt: Date
    var updatedAt: Date
}

extension Transaction: Encodable {
    static func parce(jsonObject: Any) -> Transaction? {
        guard let jsonDict = jsonObject as? [String: Any] else { return nil }
        guard
            let id = jsonDict["id"] as? Int,
            let accountId = jsonDict["accountId"] as? Int,
            let categoryId = jsonDict["categoryId"] as? Int,
            let amount = jsonDict["amount"] as? Decimal,
            let transactionDate = jsonDict["transactionDate"] as? Date,
            let comment = jsonDict["comment"] as? String,
            let createdAt = jsonDict["createdAt"] as? Date,
            let updatedAt = jsonDict["updatedAt"] as? Date
        else { return nil }
        
        
        return Transaction(
            id: id,
            accountId: accountId,
            categoryId: categoryId,
            amount: amount,
            transactionDate: transactionDate,
            comment: comment,
            createdAt: createdAt,
            updatedAt: updatedAt
        )
    }
    
    var jsonObject: Any? {
        get {
            do {
                return try JSONSerialization.jsonObject(with: try JSONEncoder().encode(self) as Data)
            }
            catch {
                return nil
            }
        }
    }
}

