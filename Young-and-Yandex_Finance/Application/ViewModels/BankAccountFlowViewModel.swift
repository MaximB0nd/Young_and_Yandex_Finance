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
    
    var status: ShowStatus = .loading
    
    var selectedHistotyPeriod: BankAccountsService.getBalancesPeriod = .month
    var balanceHistory: [LineBakanceChartData] = []
    
    private init() {
        BankAccountsService.subscribe(self)
        Task {
            try await updateBankAccounts()
        }
    }
    
    @MainActor
    func updateBankAccounts() async throws  {
        let bankAccount = try await bankService.getAccount()
        self.bankAccount = bankAccount
        await updateBalanceHistory()
        status = .loaded
    }
    
    @MainActor
    func updateBankAccount(newValue: BankAccount) async throws {
        guard try await bankService.getAccount() != newValue else {
            return
        }
        try await bankService.changeData(newBalance: newValue.balance, newCurrency: newValue.currency)
        self.bankAccount = newValue
    }
    
    @MainActor
    func updateBalanceHistory() async {
        let history = await bankService.getAllBalances(period: selectedHistotyPeriod)
        
        balanceHistory = history.map { LineBakanceChartData(date: $0.date, balance: $0.balance) }
    }
}
