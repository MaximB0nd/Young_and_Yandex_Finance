//
//  StateBankAccountFlow.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 24.06.2025.
//

import SwiftUI

struct StateBankAccountFlow: View {
    
    @Binding var mode: BankAccountFlowMode
    @Binding var account: BankAccount?
    @ObservedObject var bankAccountService: BankAccountsService
    
    
    var body: some View {
        NavigationStack {
            StateBankAccountScreen(account: $account)
                .navigationTitle(Text("Мой счет"))
                .toolbar {
                    ToolbarItem {
                        editButton
                    }
                }
        }
        
    }
    
    var editButton: some View {
        Button {
            withAnimation(.easeIn(duration: 0.2)) {
                self.mode = .edit
            }
        } label: {
            Text("Редактировать")
                .foregroundStyle(.people)
        }.buttonStyle(PlainButtonStyle())
    }
}
