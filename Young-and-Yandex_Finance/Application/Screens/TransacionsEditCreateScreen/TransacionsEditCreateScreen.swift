//
//  TransacionsEditCreateScreen.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 10.07.2025.
//

import SwiftUI

struct TransacionsEditCreateScreen {
    
    @Binding var isOpen: Bool
    
    @State var model: TodayTransactionListViewModel
    
    let id: Int?
    var category: Category?
    var amount: Decimal
    var transactionDate: Date
    var comment: String
    
    let isEdit: Bool
    
    init(direction: Direction, isOpen: Binding<Bool>) {
        self.id = nil
        self.category = nil
        self.amount = 0
        self.transactionDate = Date()
        self.comment = ""
        
        self.isEdit = false
        self._isOpen = isOpen
        
        self.model = direction == .income ? .sharedIncome : .sharedOutcome
    }
    
    init(transaction: Transaction, isOpen: Binding<Bool>) {
        self.id = transaction.id
        self.amount = transaction.amount
        self.category = transaction.category
        self.comment = transaction.comment ?? ""
        self.transactionDate = transaction.transactionDate
        
        self.isEdit = true
        self._isOpen = isOpen
        self.model = transaction.category.direction == .income ? .sharedIncome : .sharedOutcome
    }
    
    
}
