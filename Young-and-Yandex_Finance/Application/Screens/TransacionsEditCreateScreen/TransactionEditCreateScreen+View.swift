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
                    CategoryPicker(selectedCategory: $model.category)
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
            .onChange(of: model.amountText) {
                model.onChangeAmountText()
            }
            
        }
        .onDisappear {
            isOpen = false
            model.clear()
        }
    }
    
    var deleteButton: some View {
        Button {
            model.onDelete()
            withAnimation {
                isOpen = false
            }
        } label: {
            Text("Удалить \(direction == .outcome ? "расхож" : "доход")")
                .foregroundStyle(.red)
        }
    }
}
