//
//  BankAccountSwiftDataCache.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 20.07.2025.
//

import Foundation
import SwiftData

actor BankAccountDataCache {
    static var shared = BankAccountDataCache()
    
    private let modelContainer: ModelContainer
    private let context: ModelContext
    
    private init() {
        let schema = Schema([BankAccountDataModel.self])
        let config = ModelConfiguration("BankAccounts", schema: schema)
        let container = try! ModelContainer(for: schema, configurations: config)
        self.modelContainer = container
        self.context = ModelContext(container)
    }
    
    private var _accounts: [BankAccount] = []
    
    var accounts: [BankAccount] {
        _accounts
    }
    
    func add(_ backAccount: BankAccount) async {
        let model = BankAccountDataModel(from: backAccount)
        context.insert(model)
        try? context.save()
    }
    
    func delete(id: Int) async {
        let predicate = #Predicate<BankAccountDataModel> {$0.id == id}
        try? context.delete(model: BankAccountDataModel.self, where: predicate)
        try? context.save()
    }
    
    func load() async throws {
        let descriptor = FetchDescriptor<BankAccountDataModel>()
        self._accounts = try! self.context.fetch(descriptor).map(\.bankAccount)
    }
    
    func sync(_ bankAccounts: [BankAccount]) async {
        do {
            let descriptor = FetchDescriptor<BankAccountDataModel>()
            let models = try self.context.fetch(descriptor)
            models.forEach { context.delete($0) }
        } catch {}
        
        bankAccounts.forEach {
            context.insert(BankAccountDataModel(from: $0))
        }
        
        try? context.save()
    }
}
