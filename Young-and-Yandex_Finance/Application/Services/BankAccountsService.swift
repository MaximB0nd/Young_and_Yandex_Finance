//
//  BankAccountsService.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 12.06.2025.
//

import Foundation

enum BankAccountError: Error {
    case notFound
    case updateFailed
    case enotherError(code: Int, message: String)
}

final class BankAccountsService {
    private var _accounts: [BankAccount]
    
    init () {
        var accounts = [BankAccount]()
        for i in 1...10 {
            accounts.append(.init(id: i, userId: i, name: "name \(i)", balance: Decimal(i*100), currency: i%2==0 ? "RUB" : "USD", createdAt: Date.now, updatedAt: Date.now))
        }
        _accounts = accounts
    }
    
    func getAllAccount(id: Int) async throws -> BankAccount {
        guard let index = _accounts.first(where: { $0.id == id }) else {
            throw BankAccountError.notFound
        }
        return index
    }
    
    func changeBalance(id: Int, newAmount: Decimal) async throws {
        guard _accounts.contains(where: { $0.id == id }) else {
            throw BankAccountError.notFound
        }
        _accounts[_accounts.firstIndex(where: {$0.id == id})!].balance = newAmount
    }
}
