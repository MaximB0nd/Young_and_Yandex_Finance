//
//  NewTransactionViewModel+BankAccountListnerProtocol.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 11.07.2025.
//

import Foundation

extension NewTransactionViewModel: BankAccountListnerProtocol {
    func updateBankAccounts() async throws {
        let result = try await BankAccountsService.shared.getAccount()
        if result.error != nil {
            throw result.error!
        }
        self.account = Transaction.Account(bankAccount: result.success!)
    }
}
