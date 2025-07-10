//
//  BankAccountFlowViewModel.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 27.06.2025.
//

import Foundation
import SwiftUI

@Observable
final class BankAccountFlowViewModel: BankAccountListnerProtocol {
    
    static var shared = BankAccountFlowViewModel()
    
    private(set) var bankAccount: BankAccount?
    
    let bankService = BankAccountsService.shared
    
    private init() {
        Task {
            bankAccount = try await bankService.getAccount()
        }
    }
    
    @MainActor
    func updateBankAccounts() async throws  {
        bankAccount = try await bankService.getAccount()
    }
    
    @MainActor
    func updateBankAccount(newValue: BankAccount) async throws {
        guard try await bankService.getAccount() != newValue else {
            return
        }
        try await bankService.changeData(newBalance: newValue.balance, newCurrency: newValue.currency)
        self.bankAccount = newValue
    }
    
    
}
