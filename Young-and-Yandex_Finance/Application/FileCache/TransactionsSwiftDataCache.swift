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
        let container = try! ModelContainer(for: TransactionDataModel.self)
        self.modelContainer = container
        self.context = ModelContext(container)
        Task {
            try? await load()
        }
    }
    
    var _transactions: [Transaction] = []
    
    var transactions: [Transaction] {
        _transactions
    }
    
    @MainActor
    func add(_ transaction: Transaction) async {
        let model = TransactionDataModel(transaction: transaction)
        context.insert(model)
        try? context.save()
        try? await load()
    }
    
    @MainActor
    func delete(id: Int) async {
        let predicate = #Predicate<TransactionDataModel> { $0.id == id }
        try? context.delete(model: TransactionDataModel.self, where: predicate)
        try? context.save()
        try? await load()
    }
    
    @MainActor
    func load() async throws {
        let descriptor = FetchDescriptor<TransactionDataModel>()
        self._transactions = try context.fetch(descriptor).map(\.transaction)
    }
    
    @MainActor
    func sync(_ transactions: [Transaction]) async {
        try? context.delete(model: TransactionDataModel.self)
        for transaction in transactions {
            await add(transaction)
        }
    }
}
