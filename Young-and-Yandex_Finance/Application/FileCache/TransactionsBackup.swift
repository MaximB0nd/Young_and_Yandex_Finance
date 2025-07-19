//
//  TransactionsBackup.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 19.07.2025.
//

import Foundation
import SwiftData

class TransactionsBackup {
    
    let modelContainer: ModelContainer
    let context: ModelContext
    
    static let shared = TransactionsBackup()
    
    var transactions: [TransactionBackupSwiftDataModel] = []
    
    let client = NetworkClient()
    
    init() {
        let container = try! ModelContainer(for: TransactionBackupSwiftDataModel.self)
        self.modelContainer = container
        self.context = ModelContext(container)
    }
    
    func add(_ transaction: Transaction, action: Actions) {
        let model = TransactionBackupSwiftDataModel(transaction: transaction, action: action)
        context.insert(model)
        try? context.save()
    }
    
    func delete(_ transaction: Transaction, action: Actions) {
        let model = TransactionBackupSwiftDataModel(transaction: transaction, action: action)
        context.delete(model)
        try? context.save()
    }
    
    func load() throws {
        let descriptor = FetchDescriptor<TransactionBackupSwiftDataModel>()
        self.transactions = try context.fetch(descriptor)
    }
    
    func getAllNotSynced() async -> [TransactionBackupSwiftDataModel] {
        return transactions
    }
    
    func save() throws {
        try context.save()
        try load()
    }
}
