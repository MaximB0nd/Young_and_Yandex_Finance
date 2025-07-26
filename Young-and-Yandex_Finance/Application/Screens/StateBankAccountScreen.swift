//
//  BankAccountScreen.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 24.06.2025.
//

import SwiftUI

struct StateBankAccountScreen: View {
    
    @State var model = BankAccountFlowViewModel.shared
    
    var body: some View {
        
        List {
            Section {
                BankBalance(balance: model.bankAccount?.balance ?? 0, currency: model.bankAccount?.currencySymbol ?? "")
            }
            .listRowBackground(Color.accent)
            
            Section {
                BankCurrency(currency: model.bankAccount?.currencySymbol ?? "")
            }
            .listRowBackground(Color.lightAccent)
            
            BankBalanceHistoryPeriodPicher(selectedPeriod: $model.selectedHistotyPeriod)
            
           
            BankBalanceHistoryChart(data: $model.balanceHistory)
                .frame(height: 250)
            
            
                
                
        }
        .listSectionSpacing(16)
        
        .onChange(of: model.selectedHistotyPeriod) {
            Task {
                await model.updateBalanceHistory()
            }
        }
        
    }
    
}
