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
    
    // running init factory of accounts
    init () {
        var accounts = [BankAccount]()
        for i in 1...10 {
            accounts.append(.init(id: i, userId: i, name: "name \(i)", balance: Decimal(i*100), currency: i%2==0 ? "RUB" : "USD", createdAt: Date.now, updatedAt: Date.now))
        }
        _accounts = accounts
    }
    
    // get all account by id
    func getAccount(id: Int) async throws -> BankAccount {
        guard let index = _accounts.firstIndex(where: { $0.id == id }) else {
            throw BankAccountError.notFound
        }
        return _accounts[index]
    }
    
    // set new amount 
    func changeBalance(id: Int, newAmount: Decimal) async throws {
        guard let index = _accounts.firstIndex(where: {$0.id == id}) else {
            throw BankAccountError.notFound
        }
        _accounts[index].balance = newAmount
        _accounts[index].updatedAt = .now
    }
}
