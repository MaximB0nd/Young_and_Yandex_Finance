//
//  TransactionEditCreateScreen+View.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 10.07.2025.
//

import SwiftUI

extension TransacionsEditCreateScreen: View {
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    CategoryPicker(selectedCategory: $model.category, direction: direction)
                    AmountEdit(amount: $model.amount, textAmount: $model.amountText, currency: model.account?.currencySymbol  ?? "")
                    DateEditPicker(date: $model.transactionDate)
                    TimeEditPicker(time: $model.transactionDate)
                    CommentEdit(comment: $model.comment)
                }
                
                if isEdit {
                    Section {
                        deleteButton
                    }
                }
            }
            .navigationTitle("Мои \(direction == .outcome ? "расходы" : "доходы")")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    dismissButton
                }
                ToolbarItem(placement: .topBarTrailing) {
                    createButton
                }
            }
        }
        .onChange(of: model.amountText) {
            model.onChangeAmountText()
        }
        .onDisappear {
            model.clear()
        }
        .alert("Ошибка \(isEdit ? "редактирования" : "создания")",
               isPresented: $model.isError,
               actions: {}) {
            Text("\(model.getErrors)")
        }
        
    }
    
    var deleteButton: some View {
        Button {
            model.onDelete()
            dismiss()
        } label: {
            Text("Удалить \(direction == .outcome ? "расход" : "доход")")
                .foregroundStyle(.red)
        }
    }
    
    var dismissButton: some View {
        Button {
            model.clear()
            withAnimation() {
                dismiss()
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
                if model.errors.isEmpty {
                    model.clear()
                    dismiss()
                }
            }
            
        } label : {
            Text("\(isEdit ? "Сохранить" : "Создать")")
                .foregroundStyle(.people)
        }
    }
}
