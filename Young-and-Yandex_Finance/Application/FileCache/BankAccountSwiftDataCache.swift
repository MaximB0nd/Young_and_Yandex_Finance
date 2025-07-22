//
//  BankAccountSwiftDataCache.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 20.07.2025.
//

import Foundation
import SwiftData

class BankAccountSwiftDataCache {
    static var shared = BankAccountSwiftDataCache()
    
    let modelContainer: ModelContainer
    let context: ModelContext
    
    init() {
        let container = try! ModelContainer(for: BankAccountDataModel.self)
        self.modelContainer = container
        self.context = ModelContext(container)
    }
    
    private var _accounts: [Transaction] = []
    
    var accounts: [Transaction] {
        _accounts
    }
    
    func add(_ transaction: Transaction) async {
        
    }
    
    func delete(id: Int) async {
        
    }
    
    func load() async throws {
        
    }
    
    func sync(_ transactions: [Transaction]) async {
        
        
    }
}
