//
//  TransacionsEditCreateScreen.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 10.07.2025.
//

import SwiftUI

struct TransacionsEditCreateScreen {
    
    @State var model: any TransactionUpdater
    @Environment(\.dismiss) var dismiss
    
    let isEdit: Bool
    let direction: Direction
    
    init(direction: Direction) {
        self.model = direction == .income ? NewTransactionViewModel.sharedIncome : NewTransactionViewModel.sharedOutcome
        self.direction = direction
        self.isEdit = false
    }
    
    init(transaction: Transaction) {
        self.model = EditTransactionViewModel(transaction: transaction)
        self.direction = transaction.category.direction
        self.isEdit = true
    }
}
