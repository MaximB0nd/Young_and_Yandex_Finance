//
//  Transaction.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 12.06.2025.
//

import Foundation

struct Transaction: Codable {
    
    struct Account: Codable {
        let id: Int
        var name: String
        var balance: Decimal
        var currency: String
    }
    
    struct Category: Codable {
        let id: Int
        let name: String
        let emoji: String
        let direction: Direction
    }
    
    let id: Int
    let account: Account
    var category: Category
    var amount: Decimal
    var transactionDate: Date
    var comment: String?
    let createdAt: Date
    var updatedAt: Date
}
