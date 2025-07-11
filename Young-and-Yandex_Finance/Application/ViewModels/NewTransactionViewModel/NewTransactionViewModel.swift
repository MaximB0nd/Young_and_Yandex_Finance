//
//  NewTransactionViewModel.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 10.07.2025.
//

import Foundation

fileprivate enum NewTransactionError: Error {
    case noAmount
    case noCategory
}

@Observable
final class NewTransactionViewModel: TransactionUpdater {
    
    var account: BankAccount?
    let service = TransactionsService.shared
    let direction: Direction
    
    static let sharedOutcome = NewTransactionViewModel(direction: .outcome)
    static let sharedIncome = NewTransactionViewModel(direction: .income)
    
    
    var category: Category?
    var amount: Decimal?
    var transactionDate = Date()
    var comment: String = ""
    var errors: [String] = []
    var getErrors: String {
        errors.joined(separator: "\n")
    }
    var isError = false
    
    var amountText: String = ""
    
    private init(direction : Direction) {
        self.direction = direction
        Task {
            self.account = try? await BankAccountsService.shared.getAccount()
        }
        BankAccountsService.subscribe(self)
    }
    
    func doneTransaction() async {
        
        errors = []
        
        do {
            let _ = try await BankAccountsService.shared.getAccount()
        } catch {
            errors.append("Не удалось получить счет")
            isError = true
            return
        }
        
        if let _ = category {} else {
            errors.append("Выберите категорию")
        }
        
        if let _ = amount {} else {
            errors.append("Введите сумму")
        }
        
        do {
            if errors.isEmpty {
                try await TransactionsService.shared.createTransaction(
                    account: Transaction.Account(bankAccount: account!),
                    category: category!,
                    amount: amount!,
                    transactionDate: transactionDate,
                    comment: comment)
            } else {
                isError = true
            }
        } catch {
            errors = ["Не удалось создать транзакцию"]
            isError = true
        }
        
    }
    
    func onChangeAmountText() {
        let val = amountText.convertToDecimal
        amountText = val
        amount = Decimal(string: val, locale: Locale.current) ?? 0
    }
    
    func clear() {
        self.category = nil
        self.amount = nil
        self.comment = ""
        self.amountText = ""
    }
    
    func onDelete() {}
}


