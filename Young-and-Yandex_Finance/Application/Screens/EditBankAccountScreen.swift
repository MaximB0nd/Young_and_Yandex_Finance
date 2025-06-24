//
//  EditBankAccountScreen.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 24.06.2025.
//

import SwiftUI

struct EditBankAccountScreen: View {
    
    @Binding var account: BankAccount?
    
    var body: some View {
        List {
            Section {
                EditBankBalance(balance: account!.balance)
            }
        }
        .listSectionSpacing(16)
        
    }
}

