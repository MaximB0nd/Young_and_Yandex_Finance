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
    
    var transactions: [TransactionDataBackupModel] = []
    
    private init() {
        let container = try! ModelContainer(for: TransactionDataBackupModel.self)
        self.modelContainer = container
        self.context = ModelContext(container)
    }
    
    /// Add backup by transaction and action
    @MainActor
    func add(_ transaction: Transaction, action: Actions) async {
        let model = TransactionDataBackupModel(transaction: transaction, action: action)
        context.insert(model)
        try? await self.save()
    }
    
    /// Delete backup by transaction and action
    @MainActor
    func delete(_ transaction: Transaction, action: Actions) async {
        let model = TransactionDataBackupModel(transaction: transaction, action: action)
        context.delete(model)
        try? await self.save()
    }
    
    /// Load all backups
    @MainActor
    private func load() async throws {
        let descriptor = FetchDescriptor<TransactionDataBackupModel>()
        self.transactions = try context.fetch(descriptor)
    }
    
    /// Return all backups
    @MainActor
    func getBackups() -> [TransactionDataBackupModel] {
        return self.transactions
    }

    @MainActor
    func reloadBackups() async {
        let descriptor = FetchDescriptor<TransactionDataBackupModel>()
        self.transactions = (try? context.fetch(descriptor)) ?? []
    }
    
    /// Save all changes to DB
    @MainActor
    private func save() async throws {
        try context.save()
    }
}
