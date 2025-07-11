//
//  EditTransactionViewModel.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 11.07.2025.
//

import Foundation

class EditTransactionViewModel: TransactionUpdater {
    
    var service = TransactionsService.shared
    
    let id: Int
    var category: Category?
    var amount: Decimal?
    var transactionDate: Date
    var comment: String
    var amountText: String
    var account: Transaction.Account?
    var errors: [String] = []
    var isError: Bool = false
    var getErrors: String {
        errors.joined(separator: "\n")
    }
    
    func doneTransaction() async {
        if category == nil {
            errors.append("Выберите категорию")
        }
        
        if amountText == "" {
            errors.append("Введите сумму")
        }
        
        if errors.isEmpty {
            do {
                try await service.editTransaction(
                    id: id, newCategory: category,
                    newAmount: amount,
                    newTransactionDate: transactionDate,
                    newComment: comment != "" ? comment : nil)
            } catch {
                errors.append("Не удалось обновить транзакцию")
                isError = true
            }
        } else {
            isError = true
        }
    }
    
    func onChangeAmountText() {
        let val = amountText.convertToDecimal
        amountText = val
        amount = Decimal(string: val, locale: Locale.current) ?? 0
    }
    
    func clear() {}
    
    @MainActor
    func onDelete() async {
        do {
            try await service.deleteTransaction(id: id)
        } catch {
            errors.append("Не удалось удалить транзакцию")
            isError = true
        }
        
    }
    
    init(transaction: Transaction) {
        self.category = transaction.category
        self.amount = transaction.amount
        self.transactionDate = transaction.transactionDate
        self.comment = transaction.comment ?? ""
        self.account = transaction.account
        self.amountText = transaction.amount.description
        self.id = transaction.id
    }
}
