//
//  TransactionsFileCache.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 12.06.2025.
//

import Foundation

class TransactionsFileCache {
    private var _transactions: [Transaction] = []
    ;
    // getter for private var _transactions
    var transactions: [Transaction] {
        get {
            return _transactions
        }
    }
    
    // func to add a new transaction in _transactions (must have unique id)
    func add(_ transaction: Transaction) {
        guard !_transactions.contains(where: { $0.id == transaction.id }) else { return }
        _transactions.append(transaction)
    }
    
    // func to delete a transaction in _transactions by id
    func delete(id: Int) {
        _transactions.removeAll(where: { $0.id == id })
    }
    
    // func to save all t ransactions in Json file by url
    func save(fileName: String) {
        let directoryURL = FileManager.default.temporaryDirectory
        let fileURL = directoryURL.appendingPathComponent(fileName)
        let jsonDatas = _transactions.map { $0.jsonObject }
        let jsonData = try! JSONSerialization.data(withJSONObject: jsonDatas)
        try! jsonData.write(to: fileURL)
    }
    
    // func to load all transaction from Json files by urls
    func load(paths: String...) {
        let directoryURL = FileManager.default.temporaryDirectory
        for path in paths {
            let fileURL = directoryURL.appendingPathComponent(path)
            let data = try! Data(contentsOf: fileURL)
            let transactions = try! JSONDecoder().decode([Transaction].self, from: data)
            for transaction in transactions {
                if !_transactions.contains(where: { $0.id == transaction.id}) {
                    add(transaction)
                }
            }
        }
    }
}
