//
//  TransactionCoreCacher.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 22.07.2025.
//

import Foundation
import CoreData

actor TransactionsCoreCache: @preconcurrency CacheSaver {
    
    static var shared: any CacheSaver = TransactionsCoreCache()
    
    var context: NSManagedObjectContext
    let container: NSPersistentContainer
    
    private init() {
        let container = NSPersistentContainer(name: "Models")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        self.container = container
        self.context = container.viewContext
    }
    
    var transactions: [Transaction] = []
    
    func add(_ transaction: Transaction) async {
        createModel(transaction)
        try? await save()
    }
    
    func clearAllTransactions() async {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "TransactionCoreModel")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        batchDeleteRequest.resultType = .resultTypeObjectIDs
        
        do {
            let result = try context.execute(batchDeleteRequest) as? NSBatchDeleteResult
            guard let objectIDs = result?.result as? [NSManagedObjectID] else { return }
            
            let changes = [NSDeletedObjectsKey: objectIDs]
            NSManagedObjectContext.mergeChanges(
                fromRemoteContextSave: changes,
                into: [context]
            )
            
            transactions = []
            
            try await save()
            
        } catch {}
    }
    
    func delete(id: Int) async {
        do {
            let fetchRequest: NSFetchRequest<TransactionCoreModel> = TransactionCoreModel.fetchRequest()
            let objects = try context.fetch(fetchRequest)
            let deletingObject = objects.first(where: { $0.id == id })
            
            if let deletingObject = deletingObject {
                context.delete(deletingObject)
            }
            
            try? await save()
        } catch {}
    }
    
    func sync(_ transactions: [Transaction]) async {
        await clearAllTransactions()
        
        transactions.forEach { createModel($0) }
        
        try? await save()

    }
    
    func load() async throws {
        let fetchRequest: NSFetchRequest<TransactionCoreModel> = TransactionCoreModel.fetchRequest()
        let objects = try context.fetch(fetchRequest)
        var transactions = [Transaction]()
        objects.forEach {
            transactions.append(convertToTransaction($0))
        }
        self.transactions = transactions
    }
    
    func save() async throws {
        if context.hasChanges {
            try context.save()
        }
    }
    
    func createModel(_ transaction: Transaction) {
        let transactionModel = TransactionCoreModel(context: context)
        
        transactionModel.id = Int64(transaction.id)
        
        transactionModel.accountId = Int64(transaction.account.id)
        transactionModel.accountName = transaction.account.name
        transactionModel.accountBalance = transaction.account.balance as NSDecimalNumber
        transactionModel.accountCurrency = transaction.account.currency
        
        transactionModel.categoryId = Int64(transaction.category.id)
        transactionModel.categoryName = transaction.category.name
        transactionModel.categoryEmoji = String(transaction.category.emoji)
        transactionModel.isIncome = transaction.category.direction == .income
        
        transactionModel.amount = transaction.amount as NSDecimalNumber
        transactionModel.transactionDate = transaction.transactionDate
        transactionModel.comment = transaction.comment 
        transactionModel.createdAt = transaction.createdAt
        transactionModel.updatedAt = transaction.updatedAt
        
        context.insert(transactionModel)
    }
    
    func convertToTransaction(_ transactionModel: TransactionCoreModel) -> Transaction {
        let transaction: Transaction = .init(
            id: Int(transactionModel.id),
            account: .init(
                id: Int(transactionModel.accountId),
                name: transactionModel.accountName!,
                balance: transactionModel.accountBalance! as Decimal,
                currency: transactionModel.accountCurrency!),
            category: .init(
                id: Int(transactionModel.categoryId),
                name: transactionModel.categoryName!,
                emoji: transactionModel.categoryEmoji!.first!,
                direction: transactionModel.isIncome ? .income : .outcome),
            amount: transactionModel.amount! as Decimal,
            transactionDate: transactionModel.transactionDate!,
            comment: transactionModel.comment,
            createdAt: transactionModel.createdAt!,
            updatedAt: transactionModel.updatedAt!)
        
        return transaction
    }
    
    func getAndClearCache() async -> [Transaction] {
        try? await load()
        let transactions = self.transactions
        await clearAllTransactions()
        return transactions
    }
}
