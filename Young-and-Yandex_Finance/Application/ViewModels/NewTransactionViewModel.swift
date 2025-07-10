//
//  NewTransactionViewModel.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 10.07.2025.
//

import Foundation

@Observable
final class NewTransactionViewModel {
    
    
    
    func createTransaction(category: Category, amount: Decimal, transactionDate: Date, comment: String? = nil) async throws{
        let account = try await BankAccountsService.shared.getAccount()
        try await TransactionsService.shared.createTransaction(
            account: Transaction.Account(bankAccount: account),
            category: category,
            amount: amount,
            transactionDate: transactionDate,
            comment: comment)
    }
    
}
