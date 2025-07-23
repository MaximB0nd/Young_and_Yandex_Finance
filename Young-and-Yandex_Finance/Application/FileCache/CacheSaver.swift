//
//  FileCacheSaver.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 17.07.2025.
//

import Foundation

protocol CacheSaver {
    
    static var shared: CacheSaver { get }
    
    /// Getter for private var _transactions
    var transactions: [Transaction] { get }
    
    /// Add a new transaction in _transactions (must have unique id)
    func add(_ transaction: Transaction) async
    
    /// Delete a transaction in _transactions by id
    func delete(id: Int) async
    
    /// Rewrite all transactions in memory
    func sync(_ transactions: [Transaction]) async
    
    /// Read all transactions from memory
    func load() async throws
    
    func getAndClearCache() async -> [Transaction]
}
