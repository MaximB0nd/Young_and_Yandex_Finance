//
//  EdicBankAccountFlow.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 24.06.2025.
//

import SwiftUI

struct EditBankAccountFlow: View {
    
    @Binding var mode: BankAccountFlowMode
    @State var account: BankAccount
    var model: BankAccountFlowViewModel
    
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
            Task {
                try await model.updateBankAccount(newValue: account)
            }
            withAnimation(.easeIn(duration: 0.1)) {
                self.mode = .state
            }
        } label: {
            Text("Сохранить")
                .foregroundStyle(.people)
        }
        .buttonStyle(PlainButtonStyle())
    }
    
    init(mode: Binding<BankAccountFlowMode>, model: BankAccountFlowViewModel) {
        self._mode = mode
        let prev = model.bankAccount
        self.account = .init(
            id: prev?.id ?? 0,
            userId: prev?.userId ?? 0,
            name: prev?.name ?? "",
            balance: prev?.balance ?? 0,
            currency: prev?.currency ?? "",
            createdAt: prev?.createdAt ?? Date(),
            updatedAt: prev?.updatedAt ?? Date())
        self.model = model
    }
}

