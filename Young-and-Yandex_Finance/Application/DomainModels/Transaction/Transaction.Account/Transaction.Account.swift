//
//  Transaction-Account.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 13.06.2025.
//

import Foundation

extension Transaction {
    struct Account {
        let id: Int
        let name: String
        let balance: Decimal
        let currency: String
        
        init(id: Int, name: String, balance: Decimal, currency: String) {
            self.id = id
            self.balance = balance
            self.name = name
            self.currency = currency
        }
        
        init(bankAccount: BankAccount) {
            self.id = bankAccount.id
            self.balance = bankAccount.balance
            self.name = bankAccount.name
            self.currency = bankAccount.currency
        }
        
        var currencySymbol: String {
            switch currency {
            case "RUB":
                return "₽"
            case "EUR":
                return "€"
            case "USD":
                return "$"
            default:
                return ""
            }
        }
    }
}
