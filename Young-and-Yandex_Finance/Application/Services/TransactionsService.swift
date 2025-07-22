//
//  TransactionsService.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 12.06.2025.
//

import Foundation

struct TransactionListner {
    weak var listner: TransactionListnerProtocol?
}

actor TransactionsService {
    
    private static var _subscribers: [TransactionListner] = []
    
    private enum TransactionError: Error {
        case notFound
        case enotherError(code: Int, message: String)
    }
    
    static var shared = TransactionsService()
    
    private(set) var _transactions: [Transaction] = []
    
    private let cacher: CacheSaver = TransactionsDataCache.shared
    private let client = NetworkClient()
    private let backup = TransactionsBackup.shared
    
    var errorLoad: Error?
        
    private init () {}
    
    /// Load transactions from server / localy
    private func loadTransactions() async {
    
        // Internet
        await self.tryRequestToClient()
        
        do {
            _transactions = try await client.transaction.request(by: BankAccountsService.id)
            await self.cacher.sync(_transactions)
            self.errorLoad = nil
        } catch {
            switch error {
            case URLError.cancelled:
                break
            default:
                // Local
                try? await self.cacher.load()
                self._transactions = self.cacher.transactions
                await self.mergeWithBackup()
                ErrorLabelProvider.shared.showErrorLabel(with: error.localizedDescription)
                self.errorLoad = error
            }
        }
        
    }
    
    
    func tryRequestToClient() async {
        await backup.reloadBackups()
        let allbackups = await backup.getBackups()
        for backup in allbackups {
            switch backup.action {
            case .create:
               
                do {
                    let _ = try await client.transaction.request(newTransaction: .init(from: backup.transaction))
                    await self.backup.delete(by: backup.idOfAction)
                } catch {}
                
                
            case .delete:
                
                do {
                    let _: Void = try await client.transaction.request(by: backup.transaction.id)
                    await self.backup.delete(by: backup.idOfAction)
                } catch {}
                
                
            case .update:
                do {
                    let _ = try await client.transaction.request(
                        newTransaction: .init(from: backup.transaction),
                        by: backup.transaction.id)
                    await self.backup.delete(by: backup.idOfAction)
                } catch {}
            }
        }
    }
        
    /// Merge self.transactions and backups
    private func mergeWithBackup() async {
        await backup.reloadBackups()
        
        let allBackups = await backup.getBackups()
        for backup in allBackups {
            switch backup.action {
            case .create:
                self._transactions.append(backup.transaction)
            case .delete:
                self._transactions.remove(at: _transactions.firstIndex{ $0.id == backup.id }!)
            case .update:
                self._transactions.remove(at: _transactions.firstIndex{ $0.id == backup.id }!)
                self._transactions.append(backup.transaction)
            }
            
        }
    }
    
    /// Return all transactions from dateFROM to dateTO
    func getTransactions(from: Date, to: Date) async -> ResponceResult<[Transaction], Error> {
        await loadTransactions()
        
        var result = ResponceResult<[Transaction], Error>()
        result.success = _transactions.filter({$0.transactionDate >= from && $0.transactionDate <= to})
        
        result.error = self.errorLoad
        
        return result
        
    }
    
    /// Creates a new transaction and saves it on server / localy
    func createTransaction(account: Transaction.Account, category: Category, amount: Decimal, transactionDate: Date, comment: String? = nil) async throws {
        
        do {
            // Internet
            let requestModel = NetworkClient.TransactionForRequest(
                accountId: account.id,
                categoryId: category.id,
                amount: amount,
                transactionDate: transactionDate,
                comment: comment ?? "")
            
            let newTransaction = try await client.transaction.request(newTransaction: requestModel)
            await self.cacher.add(newTransaction)
            
            
        } catch {
            // Local
            let newTransactionId = (self._transactions.map(\.id).max() ?? -1) + 1
            let newTransaction = Transaction(
                id: newTransactionId + 1,
                account: account,
                category: category,
                amount: amount,
                transactionDate: transactionDate,
                comment: comment,
                createdAt: Date(),
                updatedAt: Date()
            )
            await self.backup.add(newTransaction, action: .create)
            let account = await BankAccountsService.shared.getAccount()
            try await BankAccountsService.shared.changeData(newBalance: account.success!.balance + (category.direction == .income ? amount : -amount), action: .localUpdate)
        }
        await notifySubscribers()
    }
    
    /// Edit existing transaction on server / localy and set a new value by id
    func editTransaction(id: Int, newCategory: Category? = nil, newAmount: Decimal? = nil, newTransactionDate: Date? = nil, newComment: String? = nil) async throws {
    
        do {
            guard let index = _transactions.firstIndex(where: { $0.id == id }) else {
                throw TransactionError.notFound
            }
            let requestModel = NetworkClient.TransactionForRequest(
                accountId: _transactions[index].account.id,
                categoryId: newCategory?.id ?? _transactions[index].category.id,
                amount: newAmount ?? _transactions[index].amount,
                transactionDate: newTransactionDate ?? _transactions[index].transactionDate,
                comment: newComment ?? _transactions[index].comment
            )
            let updatedTransaction = try await client.transaction.request(newTransaction: requestModel, by: _transactions[index].id)
            await self.cacher.delete(id: updatedTransaction.id)
            await self.cacher.add(updatedTransaction)
            
        } catch {
            guard let index = _transactions.firstIndex(where: { $0.id == id }) else {
                throw TransactionError.notFound
            }
            let updatedTransaction = Transaction(
                id: _transactions[index].id,
                account: _transactions[index].account,
                category: newCategory ?? _transactions[index].category,
                amount: newAmount ?? _transactions[index].amount,
                transactionDate: newTransactionDate ?? _transactions[index].transactionDate,
                comment: newComment ?? _transactions[index].comment,
                createdAt: _transactions[index].createdAt,
                updatedAt: Date())
            
            await self.backup.add(updatedTransaction, action: .update)
            if let amount = newAmount {
                let account = await BankAccountsService.shared.getAccount()
                try await BankAccountsService.shared.changeData(newBalance: account.success!.balance + (updatedTransaction.category.direction == .income ? amount : -amount), action: .localUpdate)
            }
        }
        await notifySubscribers()
    }
    
    /// Delete existing transaction on server / localy by id
    func deleteTransaction(id: Int) async throws {
        do {
            // Internet
            guard _transactions.firstIndex(where: { $0.id == id }) != nil else {
                throw TransactionError.notFound
            }
            let _: Void = try await client.transaction.request(by: id)
            await self.cacher.delete(id: id)
        } catch {
            // Local
            guard let index = _transactions.firstIndex(where: { $0.id == id }) else {
                throw TransactionError.notFound
            }
            await self.backup.add(_transactions[index], action: .delete)
        }
        await notifySubscribers()
    }
    
    /// Subscribe on notifying changes of object
    static func subscribe(listener: TransactionListnerProtocol) {
        _subscribers.append(TransactionListner(listner: listener))
    }
    
    /// Notifying subscribers
    private func notifySubscribers() async {
        for subscriber in Self._subscribers {
            await subscriber.listner?.updateTransactions()
        }
    }
}
