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
    @State var error = false
    
    var body: some View {
        NavigationStack {
            TransacionsEditCreateScreen(isOpen: $isOpen, model: model, direction: direction)
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
                .alert("Ошибка создания", isPresented: $error, actions: {}) {
                    VStack {
                        Text("Ошибка")
                        Text(model.getErrors)
                    }
                }
        }
        .onChange(of: model.errors) {
            if !model.errors.isEmpty {
                error = true
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
            model.clear()
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
            Task {
                await model.doneTransaction()
            }
            if model.errors.isEmpty {
                withAnimation {
                    isOpen = false
                }
            }
            
            model.clear()
        } label : {
            Text("Создать")
                .foregroundStyle(.people)
        }
    }
}
