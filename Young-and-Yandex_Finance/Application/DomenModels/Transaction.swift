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

extension Transaction: Encodable, Decodable {
    
    // return optional self from Json data
    static func parce(jsonObject: Any) -> Transaction? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonObject)
            let transaction = try JSONDecoder().decode(Transaction.self, from: jsonData)
            return transaction
        }
        catch {
            return nil
        }
    }
    
    // return self as Foundation object (Json)
    var jsonObject: Any {
        get {
            return try! JSONSerialization.jsonObject(with: try JSONEncoder().encode(self))
        }
    }
}

