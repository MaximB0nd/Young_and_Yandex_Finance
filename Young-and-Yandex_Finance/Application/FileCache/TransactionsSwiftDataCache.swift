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
        Task {
            try await load()
        }
    }
    
    var _transactions: [Transaction] = []
    
    var transactions: [Transaction] {
        _transactions
    }
    
    @MainActor
    func add(_ transaction: Transaction) async {
        let model = TransactionSwiftDataModel(transaction: transaction)
        context.insert(model)
        try? context.save()
        try? load()
    }
    
    @MainActor
    func delete(id: Int) async {
        let predicate = #Predicate<TransactionSwiftDataModel> { $0.id == id }
        try? context.delete(model: TransactionSwiftDataModel.self, where: predicate)
        try? context.save()
        try? load()
    }
    
    @MainActor
    private func load() throws {
        let descriptor = FetchDescriptor<TransactionSwiftDataModel>()
        self._transactions = try context.fetch(descriptor).map(\.transaction)
    }
}
