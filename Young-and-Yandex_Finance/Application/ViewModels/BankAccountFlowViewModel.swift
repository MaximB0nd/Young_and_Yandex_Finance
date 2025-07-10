//
//  BankAccountFlowViewModel.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 27.06.2025.
//

import Foundation
import SwiftUI

@Observable
final class BankAccountFlowViewModel {
    
    
    
    static var shared = BankAccountFlowViewModel()
    
    private(set) var bankAccount: BankAccount?
    
    let bankService = BankAccountsService.shared
    let id: Int?
    
    private init() {
        self.id = Self.id
        Task {
            guard let id else { return }
            bankAccount = try await bankService.getAccount(id: id)
        }
    }
    
    @MainActor
    func fetchBankAccounts() async throws  {
        guard let id else { return }
        bankAccount = try await bankService.getAccount(id: id)
    }
    
    @MainActor
    func updateBankAccount(newValue: BankAccount) async throws {
        guard let id else { return }
        guard try await bankService.getAccount(id: id) != newValue else {
            return
        }
        try await bankService.changeData(id: id, newBalance: newValue.balance, newCurrency: newValue.currency)
        self.bankAccount = newValue
    }
    
    
}
