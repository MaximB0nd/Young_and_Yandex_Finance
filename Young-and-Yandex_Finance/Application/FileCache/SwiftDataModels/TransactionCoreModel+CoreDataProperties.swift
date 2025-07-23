//
//  TransactionCoreModel+CoreDataProperties.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 23.07.2025.
//
//

import Foundation
import CoreData


extension TransactionCoreModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TransactionCoreModel> {
        return NSFetchRequest<TransactionCoreModel>(entityName: "TransactionCoreModel")
    }

    @NSManaged public var accountBalance: NSDecimalNumber?
    @NSManaged public var accountCurrency: String?
    @NSManaged public var accountId: Int64
    @NSManaged public var accountName: String?
    @NSManaged public var amount: NSDecimalNumber?
    @NSManaged public var categoryEmoji: String?
    @NSManaged public var categoryId: Int64
    @NSManaged public var categoryName: String?
    @NSManaged public var comment: String?
    @NSManaged public var createdAt: Date?
    @NSManaged public var id: Int64
    @NSManaged public var isIncome: Bool
    @NSManaged public var transactionDate: Date?
    @NSManaged public var updatedAt: Date?

}

extension TransactionCoreModel : Identifiable {

}
