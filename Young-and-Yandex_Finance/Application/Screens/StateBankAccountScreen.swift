//
//  BankAccountScreen.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 24.06.2025.
//

import SwiftUI

struct StateBankAccountScreen: View {
    
    @ObservedObject var model: BankAccountFlowViewModel
    
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
                
        }
        .listSectionSpacing(16)
    }
    
}
