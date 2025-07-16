//
//  NetworkClient+BankAccount.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 15.07.2025.
//

import Foundation

extension NetworkClient {
    struct BankAccountForRequest: Codable {
        let name: String
        let balance: Decimal
        let currency: String
    }
}
