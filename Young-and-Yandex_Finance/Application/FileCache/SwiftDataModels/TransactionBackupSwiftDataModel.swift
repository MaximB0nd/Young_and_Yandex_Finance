//
//  TransactionBackupSwiftDataModel.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 19.07.2025.
//

import Foundation
import SwiftData

enum Actions: Codable {
    case create
    case update
    case delete
}

@Model
final class TransactionBackupSwiftDataModel {
    @Attribute(.unique)
    var id = UUID()
    
    var transaction: TransactionSwiftDataModel
    
    var action: Actions
    
    init(transaction: Transaction, action: Actions) {
        self.transaction = .init(transaction: transaction)
        self.action = action
    }
}
