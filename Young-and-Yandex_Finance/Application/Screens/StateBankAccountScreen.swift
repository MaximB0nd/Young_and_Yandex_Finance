//
//  BankAccountScreen.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 24.06.2025.
//

import SwiftUI

struct StateBankAccountScreen: View {
    
    @Binding var account: BankAccount?
    
    var body: some View {
        List {
            Section {
                BankBalance(balance: account!.balance, currency: account!.currencySymbol)
                    
            }
            .listRowBackground(Color.accent)
            
            
            Section {
                BankCurrency(currency: account!.currencySymbol)
            }
            .listRowBackground(Color.lightAccent)
                
        }
        .listSectionSpacing(16)
    }
    
}
