//
//  BankAccountsService.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 12.06.2025.
//

import Foundation

fileprivate enum LazyLoading {
    case noninitialized
    case initialized(BankAccountsService)
}

fileprivate struct BankAccountListner {
    weak var listener: BankAccountListnerProtocol?
}

actor BankAccountsService {
    
    private static var subscribers: [BankAccountListner] = []
    
    static func subscribe(_ listener: BankAccountListnerProtocol) {
        subscribers.append(BankAccountListner(listener: listener))
    }
    
    func notifySubscribers() async {
        for subscriber in Self.subscribers {
            try? await subscriber.listener?.updateBankAccounts()
        }
    }
    
    static let shared = BankAccountsService()
    
    private enum BankAccountError: Error {
        case notFound
        case updateFailed
        case enotherError(code: Int, message: String)
    }
    
    private(set) var _accounts: [BankAccount] = []
    
    let client = NetworkClient()
    
    static private var lazyLoading: LazyLoading = .noninitialized
    static var id = 77
    
    var id: Int {
        Self.id
    }
    
    // running init factory of accounts
    private init () {}
    
    private func load() async throws {
        do {
            self._accounts = try await client.account.request()
        } catch {
            self._accounts = []
            throw error
        }
    
    }
    
    // get all account by id
    func getAccount() async throws -> ResponceResult<BankAccount, Error> {
        
        try await load()
        
        var result = ResponceResult<BankAccount, Error>()
        do {
            try await load()
        } catch {
            result.error = error
        }
        
        guard let index = _accounts.firstIndex(where: { $0.id == id }) else {
            throw BankAccountError.notFound
        }
        
        result.success = _accounts[index]
        
        return result
    }
    
    func changeData(newName: String? = nil, newBalance: Decimal? = nil, newCurrency: String? = nil) async throws {
        
        guard let index = _accounts.firstIndex(where: {$0.id == id}) else {
            throw BankAccountError.notFound
        }
        
//        let newAccount = try await client.account.request(newAccount: .init(name: newName ?? _accounts[index].name, balance: newBalance ?? _accounts[index].balance, currency: newCurrency ?? _accounts[index].currency), by: id)
        
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
        
        await notifySubscribers()

    }
}
