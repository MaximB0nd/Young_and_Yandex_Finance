//
//  CreateTransactionFlow.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 10.07.2025.
//

import SwiftUI

struct CreateTransactionFlow: View {
    
    @Binding var isOpen: Bool
    let direction: Direction
    
    @State var model: NewTransactionViewModel
    
    var body: some View {
        NavigationStack {
            TransacionsEditCreateScreen(isOpen: $isOpen, model: model)
                .navigationTitle("Мои расходы")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        dismissButton
                    }
                    ToolbarItem(placement: .topBarTrailing) {
                        createButton
                    }
                }
                .onDisappear {
                    model.clear()
                }
        }
    }
    
    init(isOpen: Binding<Bool>, direction: Direction) {
        self._isOpen = isOpen
        self.direction = direction
        self.model = direction == .income ? .sharedIncome : .sharedOutcome
    }
    
    var dismissButton: some View {
        Button {
            withAnimation() {
                isOpen = false
            }
        } label: {
            Text("Отмена")
                .foregroundStyle(.people)
        }
    }
    
    var createButton: some View {
        Button {
            withAnimation {
                isOpen = false
            }
        } label : {
            Text("Создать")
                .foregroundStyle(.people)
        }
    }
}
