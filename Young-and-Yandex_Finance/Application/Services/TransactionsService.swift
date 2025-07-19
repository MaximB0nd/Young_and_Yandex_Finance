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

@Observable
final class TransactionsService{
    
    private static var _subscribers: [TransactionListner] = []
    
    private enum TransactionError: Error {
        case notFound
        case enotherError(code: Int, message: String)
    }
    
    static var shared = TransactionsService()
    
    private(set) var _transactions: [Transaction] = []
    
    private let cacher: CacheSaver = TransactionsFileCache.shared
    private let client = NetworkClient()
    private let backup = TransactionsBackup.shared
        
    private init () {
        Task {
            await loadTransactions()
        }
    }
    
    // Делаем loadTransactions асинхронным и возвращающим результат только после загрузки
    func loadTransactions() async -> [Transaction] {
        
    }
    
    func tryRequestToClient() async {
        
    }
    
    func mergeBackup(with transactions: [TransactionBackupSwiftDataModel]) async -> [Transaction] {
        
        
    }
    
    func getTransactions(from: Date, to: Date) async -> ResponceResult<[Transaction], Error> {
        
        
    }
    
    
    func createTransaction(account: Transaction.Account, category: Category, amount: Decimal, transactionDate: Date, comment: String? = nil) async {
        
        
        
        await notifySubscribers()
    }
    
    func editTransaction(id: Int, newCategory: Category? = nil, newAmount: Decimal? = nil, newTransactionDate: Date? = nil, newComment: String? = nil) async throws {
    
        
        
        
        
        await notifySubscribers()
    }
    
    func deleteTransaction(id: Int) async throws {
        
       
        
        await notifySubscribers()
    }
    
    static func subscribe(listener: TransactionListnerProtocol) {
        _subscribers.append(TransactionListner(listner: listener))
    }
    
    func notifySubscribers() async {
        for subscriber in Self._subscribers {
            await subscriber.listner?.updateTransactions()
        }
    }
}
