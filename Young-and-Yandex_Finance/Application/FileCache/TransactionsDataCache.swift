//
//  TransactionsSwiftDataCache.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 17.07.2025.


import Foundation
import SwiftData

actor TransactionsDataCache: @preconcurrency CacheSaver {
    
    static var shared: CacheSaver = TransactionsDataCache()
    
    let modelContainer: ModelContainer
    let context: ModelContext
    
    private init() {
        do {
            let schema = Schema([TransactionDataModel.self])
            let config = ModelConfiguration("TransactionDataModel", schema: schema)
            let container = try ModelContainer(for: schema, configurations: config)
            
            self.modelContainer = container
            self.context = ModelContext(container)
            
        } catch {
            fatalError("Failed to create ModelContainer: \(error)")
        }
    }
    
    var _transactions: [Transaction] = []
    
    var transactions: [Transaction] {
        _transactions
    }
    
    func add(_ transaction: Transaction) async {
        let model = TransactionDataModel(transaction: transaction)
        context.insert(model)
        try? context.save()
    }
    
    func delete(id: Int) async {
        let predicate = #Predicate<TransactionDataModel> { $0.id == id }
        try? context.delete(model: TransactionDataModel.self, where: predicate)
        try? context.save()
    }
    
    func load() async throws {
        let descriptor = FetchDescriptor<TransactionDataModel>()
        self._transactions = try context.fetch(descriptor).map(\.transaction)
    }
    
    func sync(_ transactions: [Transaction]) async {
        
        do {
            let descriptor = FetchDescriptor<TransactionDataModel>()
            let models = try context.fetch(descriptor)
            models.forEach { context.delete($0) }
        } catch {}
        
        transactions.forEach {
            context.insert(TransactionDataModel(transaction: $0))
        }
        
        try? context.save()
    }
}
