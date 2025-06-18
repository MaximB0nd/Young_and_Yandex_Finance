//
//  Transaction-Json.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 12.06.2025.
//

import Foundation

extension Transaction {
    
    // return optional self from Json data
    static func parse(jsonObject: Any) -> Transaction? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonObject)
                    
            let transaction = try JSONDecoder().decode(Transaction.self, from: jsonData)
            return transaction
        }
        catch {
            print(error)
            return nil
        }
    }
    
    // return self as Foundation object (Json)
    var jsonObject: Any {
        try! JSONSerialization.jsonObject(with: try JSONEncoder().encode(self))
    }
}
