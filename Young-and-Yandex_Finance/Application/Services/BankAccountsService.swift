//
//  BankAccountsService.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 12.06.2025.
//

import Foundation

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
    
    private var _accounts: [BankAccount] = []
    
    let client = NetworkClient()
    let cacher = BankAccountDataCache.shared
    let backup = BankAccountBackup.shared
    
    static var id = 77
    
    var id: Int {
        Self.id
    }
    
    // running init factory of accounts
    private init () {}
    
    private func load() async {
        
        // Internet
        await TransactionsService.shared.tryRequestToClient()
        await tryRequestToClient()

        do {
            self._accounts = try await client.account.request()
            await cacher.sync(_accounts)
        } catch {
            switch error {
            case URLError.cancelled:
                break
            default:
                // Local
                try? await self.cacher.load()
                self._accounts = await self.cacher.accounts
                await self.mergeWithBackup()
                ErrorLabelProvider.shared.showErrorLabel(with: error.localizedDescription)
            }
        }
    
    }
    
    func tryRequestToClient() async {
        await backup.reloadBackups()
        let allBackups = await backup.getBackups()

        for backup in allBackups {
            
            do {
                let _ = try await client.account.request(newAccount: .init(from: backup.bankAccount), by: backup.id)
                await self.backup.delete(by: backup.idOfAction)
            } catch {}
            
        }
    }
    
    private func mergeWithBackup() async {
        await backup.reloadBackups()
        
        let allBackups = await backup.getBackups()
        for backup in allBackups {
            self._accounts.remove(at: _accounts.firstIndex(where: {$0.id == backup.id})!)
            self._accounts.append(backup.bankAccount)
        }
        
    }
    
    // get all account by id
    func getAccount() async throws-> BankAccount {
        
        await self.load()
        
        guard let index = _accounts.firstIndex(where: { $0.id == id }) else {
            throw BankAccountError.notFound
        }
        
        return _accounts[index]
    }
    
    func changeData(newName: String? = nil, newBalance: Decimal? = nil, newCurrency: String? = nil) async throws {
        
        do {
            // Internet
            guard let index = _accounts.firstIndex(where: {$0.id == id}) else {
                throw BankAccountError.notFound
            }
            
            let requestModel = NetworkClient.BankAccountForRequest(
                name: newName ?? _accounts[index].name,
                balance: newBalance ?? _accounts[index].balance,
                currency: newCurrency ?? _accounts[index].currency)
            
            let updatedAccount = try await client.account.request(newAccount: requestModel, by: id)
            
            await self.cacher.delete(id: updatedAccount.id)
            await self.cacher.add(updatedAccount)
            
        } catch {
            // Local
            
            guard let index = _accounts.firstIndex(of: _accounts.first(where: {$0.id == id})!) else {
                throw BankAccountError.notFound
            }
            
            let updatedAccount = BankAccount(
                id: _accounts[index].id,
                userId: _accounts[index].userId,
                name: newName ?? _accounts[index].name,
                balance: newBalance ?? _accounts[index].balance,
                currency: newCurrency ?? _accounts[index].currency,
                createdAt: _accounts[index].createdAt,
                updatedAt: Date())
            
            await self.backup.add(updatedAccount)
            
        }
        
        await notifySubscribers()

    }
}
