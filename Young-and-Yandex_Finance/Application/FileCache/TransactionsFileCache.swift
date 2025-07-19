//
//  TransactionsFileCache.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 12.06.2025.
//

import Foundation

class TransactionsFileCache: CacheSaver {
    
    static var shared: CacheSaver = TransactionsFileCache()
    
    private enum FileCacheErrors: Error {
        case fileNotFound
        case decodingError(String)
    }
    
    private let fileName = "Y&Y_Finance-transactions.json"
    
    internal var _transactions: [Transaction] = []
    
    /// Getter for private var _transactions
    var transactions: [Transaction] {
        _transactions
    }
    
    /// Add a new transaction in transactions (must have unique id)
    @MainActor
    func add(_ transaction: Transaction) async {
        guard !_transactions.contains(where: { $0.id == transaction.id }) else { return }
        _transactions.append(transaction)
        try? await save()
    }
    
    /// Delete a transaction in transactions by id
    @MainActor
    func delete(id: Int) async {
        _transactions.removeAll(where: { $0.id == id })
        try? await save()
    }
    
    /// Save all transactions in Json file by url
    @MainActor
    private func save() async throws {
        let directoryURL = FileManager.default.temporaryDirectory
        let fileURL = directoryURL.appendingPathComponent(fileName)
        let jsonDatas = _transactions.map { $0.jsonObject }
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: jsonDatas)
            try jsonData.write(to: fileURL)
        } catch {
            throw FileCacheErrors.decodingError("Can not convert to JSON")
        }
    }
    
    /// Load all transaction from Json files by urls
    @MainActor
    func load() async throws {
        let paths = [fileName]
        let directoryURL = FileManager.default.temporaryDirectory
        for path in paths {
            let fileURL = directoryURL.appendingPathComponent(path)
            do {
                let data = try Data(contentsOf: fileURL)
                let transactions = try JSONDecoder().decode([Transaction].self, from: data)
                for transaction in transactions {
                    if !_transactions.contains(where: { $0.id == transaction.id}) {
                        await add(transaction)
                    }
                }
            } catch {
                switch error {
                case DecodingError.dataCorrupted:
                    throw FileCacheErrors.decodingError("Can not decode JSON")
                default:
                    throw FileCacheErrors.fileNotFound
                }
            }  
        }
    }
    
    @MainActor
    func sync(_ transactions: [Transaction]) async {
        _transactions = transactions
        try? await save()
    }
}
