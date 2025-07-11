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
    
    let service = TransactionsService.shared
    
    let direction: Direction
    
    static let sharedOutcome = NewTransactionViewModel(direction: .outcome)
    static let sharedIncome = NewTransactionViewModel(direction: .income)
    
    private init(direction : Direction) {
        self.direction = direction
    }

    var category: Category?
    var amount: Decimal?
    var transactionDate = Date()
    var comment: String?
    
    var amountText: String = ""
    
    func doneTransaction() async throws {
        let account = try await BankAccountsService.shared.getAccount()
        
        guard let category = category else {
            throw NewTransactionError.noCategory
        }
        
        guard let amount = amount else {
            throw NewTransactionError.noAmount
        }
        
        try await TransactionsService.shared.createTransaction(
            account: Transaction.Account(bankAccount: account),
            category: category,
            amount: amount,
            transactionDate: transactionDate,
            comment: comment)
    }
    
    func onChangeAmountText() {
        let val = amountText.convertToDecimal
        amountText = val
        amount = Decimal(string: val, locale: Locale.current) ?? 0
    }
    
    func clear() {
        self.category = nil
        self.amount = nil
        self.comment = nil
        self.amountText = ""
    }
}


