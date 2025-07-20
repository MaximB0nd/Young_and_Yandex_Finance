//
//  TransactionsSwiftDataCache.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 17.07.2025.


import Foundation
import SwiftData
import SwiftUI

final class TransactionsSwiftDataCache: CacheSaver {
    
    static var shared: CacheSaver = TransactionsSwiftDataCache()
    
    let modelContainer: ModelContainer
    let context: ModelContext
    
    init() {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: TransactionDataModel.self, configurations: config)
        self.modelContainer = container
        self.context = ModelContext(container)
    }
    
    var _transactions: [Transaction] = []
    
    var transactions: [Transaction] {
        _transactions
    }
    
    func add(_ transaction: Transaction) async {
        let model = TransactionDataModel(transaction: transaction)
        context.insert(model)
        try? context.save()
        try? await load()
    }
    
    func delete(id: Int) async {
        let predicate = #Predicate<TransactionDataModel> { $0.id == id }
        try? context.delete(model: TransactionDataModel.self, where: predicate)
        try? context.save()
        try? await load()
    }
    
    func load() async throws {
        let descriptor = FetchDescriptor<TransactionDataModel>()
        self._transactions = try context.fetch(descriptor).map(\.transaction)
    }
    
    func sync(_ transactions: [Transaction]) async {
        
        print("\n\n\n\n\n-----sync-----\n\n\n\n\n")
        
        try! context.delete(model: TransactionDataModel.self)
        for transaction in transactions {
            await add(transaction)
        }
    }
}
