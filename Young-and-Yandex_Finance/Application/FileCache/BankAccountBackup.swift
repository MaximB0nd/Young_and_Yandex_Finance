//
//  BankAccountBackup.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 22.07.2025.
//

import Foundation
import SwiftData

actor BankAccountBackup {
    
    let modelContainer: ModelContainer
    let context: ModelContext
    
    static let shared = BankAccountBackup()
    
    var bankAccounts: [BankAccountDataBackupModel] = []
    
    private init() {
        let schema = Schema([BankAccountDataBackupModel.self])
        let config = ModelConfiguration("BancAccountsBackup", schema: schema)
        let container = try! ModelContainer(for: schema, configurations: config)
        self.modelContainer = container
        self.context = ModelContext(container)
        
    }
    
    /// Add backup by bankAccount and action
    func add(_ backAccount: BankAccount) async {
        let model = BankAccountDataBackupModel(from: backAccount)
        context.insert(model)
        try? await self.save()
    }
    
    /// Delete backup by idOfAction of backAccount
    func delete(by id: UUID) async {
        let predicate = #Predicate<BankAccountDataBackupModel> {$0.idOfAction == id}
        try? context.delete(model: BankAccountDataBackupModel.self, where: predicate)
        try? await self.save()
    }
    
    /// Load all backups
    private func load() async throws {
        let descriptor = FetchDescriptor<BankAccountDataBackupModel>()
        self.bankAccounts = try context.fetch(descriptor)
    }
    
    /// Return all backups
    func getBackups() -> [BankAccountDataBackupModel] {
        return self.bankAccounts
    }

    func reloadBackups() async {
        let descriptor = FetchDescriptor<BankAccountDataBackupModel>()
        self.bankAccounts = (try? context.fetch(descriptor))?.sorted(by: {$0.dateOfAction < $1.dateOfAction}) ?? []
    }
    
    /// Save all changes
    private func save() async throws {
        try context.save()
    }
}


