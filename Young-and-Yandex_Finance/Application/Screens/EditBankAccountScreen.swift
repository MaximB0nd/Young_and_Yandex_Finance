//
//  EditBankAccountScreen.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 24.06.2025.
//

import SwiftUI

struct EditBankAccountScreen: View {
    
    @Binding var account: BankAccount
    
    var body: some View {
        List {
            Section {
                EditBankBalance(balance: Binding(get: {account.balance}, set: {newValue in account.balance = newValue}))
            }
            Section {
                EditBankCurrency(currency: Binding(get: {account.currency}, set: {newValue in account.currency = newValue}))
            }
        }
        .listSectionSpacing(16)
        .scrollDismissesKeyboard(.immediately)
    }
}

