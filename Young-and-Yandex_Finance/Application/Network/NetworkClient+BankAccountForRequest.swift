//
//  NetworkClient+BankAccount.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 15.07.2025.
//

import Foundation

extension NetworkClient {
    struct BankAccountForRequest: Encodable {
        let name: String
        let balance: Decimal
        let currency: String
        
        init(from backAccount: BankAccount) {
            self.name = backAccount.name
            self.balance = backAccount.balance
            self.currency = backAccount.currency
        }
        
        init(name: String, balance: Decimal, currency: String) {
            self.name = name
            self.balance = balance
            self.currency = currency
        }
    }
}
