//
//  TransactionsSwiftDataCache.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 17.07.2025.
//

import Foundation
import SwiftData
import SwiftUI

final class TransactionsSwiftDataCache: CacheSaver {
    
    static var shared: any CacheSaver = TransactionsSwiftDataCache()
    
    let modelContainer: ModelContainer
    let context: ModelContext
    
    init() {
        let container = try! ModelContainer(for: TransactionSwiftDataModel.self)
        self.modelContainer = container
        self.context = ModelContext(container)
        try? load()
    }
    
    var _transactions: [Transaction] = []
    
    var transactions: [Transaction] {
        _transactions
    }
    
    func add(_ transaction: Transaction) {
        let model = TransactionSwiftDataModel(transaction: transaction)
        context.insert(model)
        try? save()
    }
    
    func delete(id: Int) {
        let predicate = #Predicate<TransactionSwiftDataModel> { $0.id == id }
        try? context.delete(model: TransactionSwiftDataModel.self, where: predicate)
        try? save()
    }
    
    func load() throws {
        let descriptor = FetchDescriptor<TransactionSwiftDataModel>()
        self._transactions = try context.fetch(descriptor).map(\.transaction)
    }
    
    func save() throws {
        try context.save()
    }
    
    func rewrite(_ transactions: [Transaction]) throws {
        self._transactions = transactions
        try context.delete(model: TransactionSwiftDataModel.self)
        for transaction in transactions {
            add(transaction)
        }
        try save()
    }
}
