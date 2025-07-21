//
//  TransactionsBackup.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 19.07.2025.
//

import Foundation
import SwiftData

actor TransactionsBackup {
    
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
    func add(_ transaction: Transaction, action: Actions) async {
        let model = TransactionDataBackupModel(transaction: transaction, action: action)
        context.insert(model)
        try? await self.save()
    }
    
    /// Delete backup by transaction and action
    func delete(by id: UUID) async {
        let predicate = #Predicate<TransactionDataBackupModel> {$0.idOfAction == id}
        try? context.delete(model: TransactionDataBackupModel.self, where: predicate)
        try? await self.save()
    }
    
    /// Load all backups
    private func load() async throws {
        let descriptor = FetchDescriptor<TransactionDataBackupModel>()
        self.transactions = try context.fetch(descriptor)
    }
    
    /// Return all backups
    func getBackups() -> [TransactionDataBackupModel] {
        return self.transactions
    }

    func reloadBackups() async {
        let descriptor = FetchDescriptor<TransactionDataBackupModel>()
        self.transactions = (try? context.fetch(descriptor))?.sorted(by: {$0.dateOfAction > $1.dateOfAction}) ?? []
    }
    
    /// Save all changes to DB
    private func save() async throws {
        try context.save()
    }
}
