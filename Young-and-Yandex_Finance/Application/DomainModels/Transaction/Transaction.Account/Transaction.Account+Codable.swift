//
//  Transaction.Account+Codable.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 20.06.2025.
//

import Foundation

extension Transaction.Account: Codable {
    private enum CodingKeys: String, CodingKey {
        case id, name, balance, currency
    }
    
    init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        let balance = try container.decode(String.self, forKey: .balance)
        self.balance = Decimal(string: balance) ?? 0.0
        self.currency = try container.decode(String.self, forKey: .currency)
    }
    
    func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(currency, forKey: .currency)
        let balance = "\(self.balance)"
        try container.encode(balance, forKey: .balance)
    }
    
}
