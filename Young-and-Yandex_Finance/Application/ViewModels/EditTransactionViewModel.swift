//
//  EditTransactionViewModel.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 11.07.2025.
//

import Foundation

class EditTransactionViewModel: TransactionUpdater {
    var errors: [String] = []
    
    var getErrors: String {
        return errors.joined(separator: "\n")
    }
    
    func doneTransaction() async {
        
    }
    
    func onDelete() {
        
    }
    
    var account: BankAccount?
    
    var amountText: String
    
    func onChangeAmountText() {
        
    }
    
    func clear() {
        
    }
    
    var category: Category?
    
    var amount: Decimal?
    
    var transactionDate: Date
    
    var comment: String
    
    init(transaction: Transaction) {
        self.category = transaction.category
        self.amount = transaction.amount
        self.transactionDate = transaction.transactionDate
        self.comment = transaction.comment ?? ""
        self.amountText = transaction.amount.description
    }
}
