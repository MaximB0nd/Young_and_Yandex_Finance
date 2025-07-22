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
    
    var account: Transaction.Account?
    let service = TransactionsService.shared
    let direction: Direction
    
    var category: Category?
    var amount: Decimal?
    var transactionDate = Date()
    var comment: String = ""
    var errors: [String] = []
    var getErrors: String {
        errors.joined(separator: "\n")
    }
    var isError = false
    var status: ShowStatus = .loading
    
    
    var amountText: String = ""
    
    init(direction : Direction) {
        self.direction = direction
        Task {
            let result = await BankAccountsService.shared.getAccount()
            
            if let account = result.success {
                self.account = Transaction.Account(bankAccount: account)
            }
        }
        BankAccountsService.subscribe(self)
    }
    
    func doneTransaction() async {
        
        errors = []
   
        let result = await BankAccountsService.shared.getAccount()
        if let account = result.success {
            self.account = Transaction.Account(bankAccount: account)
        }
        else {
            errors.append("Не удалось получить счет")
            isError = true
            return
        }
        
        
        if let _ = category {} else {
            errors.append("Выберите категорию")
        }
        
        if amountText == "" {
            errors.append("Введите сумму")
        }
        
        
        if errors.isEmpty {
            do {
                try await TransactionsService.shared.createTransaction(
                    account: account!,
                    category: category!,
                    amount: amount!,
                    transactionDate: transactionDate,
                    comment: comment)
            } catch {
                errors = [error.localizedDescription]
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
    
    func clear()  {
        self.category = nil
        self.amount = nil
        self.comment = ""
        self.amountText = ""
    }
    
    func onDelete() {}
}


