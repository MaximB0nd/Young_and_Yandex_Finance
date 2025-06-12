//
//  TransactionsFileCache.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 12.06.2025.
//

import Foundation

class TransactionsFileCache {
    private var _transactions: [Transaction] = []
    
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
    func save(url: URL) {
        let jsonDatas = _transactions.map { $0.jsonObject }
        let jsonData = try! JSONSerialization.data(withJSONObject: jsonDatas)
        try! jsonData.write(to: url)
    }
    
    // func to load all transaction from Json files by urls
    func load(urls: URL...) {
        for url in urls {
            guard FileManager.default.fileExists(atPath: url.path) else { continue }
            let data = try! Data(contentsOf: url)
            let jsonObj = try! JSONSerialization.jsonObject(with: data)
            guard let transaction = Transaction.parce(jsonObject: jsonObj) else { continue }
            self.add(transaction)
        }
    }
}
