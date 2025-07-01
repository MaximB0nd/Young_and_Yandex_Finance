//
//  BankAccountFlowViewModel.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 27.06.2025.
//

import Foundation

final class BankAccountFlowViewModel: ObservableObject {
    
    @Published private(set) var bankAccount: BankAccount?
    
    let bankService = BankAccountsService.shared
    let id: Int
    
    init(id: Int) {
        self.id = id
        Task {
            bankAccount = try await bankService.getAccount(id: id)
        }
    }
    
    @MainActor
    func fetchBankAccounts() async throws  {
        bankAccount = try await bankService.getAccount(id: id)
    }
    
    @MainActor
    func updateBankAccount(newValue: BankAccount) async throws {
        guard try await bankService.getAccount(id: id) != newValue else {
            return
        }
        
        try await bankService.changeData(id: id, newBalance: newValue.balance, newCurrency: newValue.currency)
    }
    
    
}
