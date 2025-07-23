//
//  NewTransactionViewModel+BankAccountListnerProtocol.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 11.07.2025.
//

import Foundation

extension NewTransactionViewModel: BankAccountListnerProtocol {
    func updateBankAccounts() async throws {
        let bankAccount = try await BankAccountsService.shared.getAccount()
        self.account = Transaction.Account(bankAccount: bankAccount)
    }
}
