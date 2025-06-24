//
//  EdicBankAccountFlow.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 24.06.2025.
//

import SwiftUI

struct EditBankAccountFlow: View {
    
    @Binding var mode: BankAccountFlowMode
    @Binding var account: BankAccount?
    @ObservedObject var bankAccountService: BankAccountsService
    
    var body: some View {
        NavigationStack {
            EditBankAccountScreen(account: $account)
                .navigationTitle(Text("Мой счет"))
                .toolbar {
                    ToolbarItem {
                        saveButton
                    }
                }
        }
    }
    
    var saveButton: some View {
        Button {
            withAnimation(.easeIn(duration: 0.2)) {
                self.mode = .state
            }
        } label: {
            Text("Сохранить")
                .foregroundStyle(.people)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

