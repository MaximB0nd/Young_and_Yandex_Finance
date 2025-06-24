//
//  BankAccountsService.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 12.06.2025.
//

import Foundation

final class BankAccountsService: ObservableObject {
    
    private enum BankAccountError: Error {
        case notFound
        case updateFailed
        case enotherError(code: Int, message: String)
    }
    
    @Published private(set) var _accounts: [BankAccount]
    
    // running init factory of accounts
    init () {
        var accounts = [BankAccount]()
        for i in 1...10 {
            accounts.append(
                .init(
                    id: i,
                    userId: i,
                    name: "Max",
                    balance: Decimal(i*100),
                    currency: i % 2 == 0 ? "USD" : "RUB",
                    createdAt: Date.now,
                    updatedAt: Date.now)
            )
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
    func changeBalance(id: Int, newName: String?, newBalance: Decimal?, newCurrency: String?) async throws {
        guard let index = _accounts.firstIndex(where: {$0.id == id}) else {
            throw BankAccountError.notFound
        }
        
        var isChanged = false
        
        if let newName = newName, _accounts[index].name != newName {
            isChanged = true
            _accounts[index].name = newName
        }
        
        if let newBalance = newBalance, _accounts[index].balance != newBalance {
            isChanged = true
            _accounts[index].balance = newBalance
        }
        
        if let newCurrency = newCurrency, _accounts[index].currency != newCurrency {
            isChanged = true
            _accounts[index].currency = newCurrency
        }
        
        if isChanged { _accounts[index].updatedAt = .now }
    }
}
