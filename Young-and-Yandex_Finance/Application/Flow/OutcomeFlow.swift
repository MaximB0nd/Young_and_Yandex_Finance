//
//  OutcomeFlow.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 18.06.2025.
//

import SwiftUI

struct OutcomeFlow: View {
    
    @ObservedObject var transactionService: TransactionsService
    
    var body: some View {
        NavigationStack {
            OutcomeScreen(transactionService: transactionService)
                .navigationTitle(LocalizedStringKey("Расходы сегодня"))
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        minusButton
                    }
                    ToolbarItem(placement: .topBarLeading) {
                        plusButton
                    }
                }
        }
    }
    
    var plusButton: some View {
        Button("+"){
            Task{try! await transactionService.createTransaction(
                account:
                        .init(
                            id: 1,
                            name: "Max",
                            balance: 1000,
                            currency: "RUB"),
                category: .init(id: 1, name: "Inding", emoji: "🐕", direction: .outcome),
                amount: 100,
                transactionDate: .now)
            }
        }
    }
    
    var minusButton: some View {
        Button("-"){
            Task {
                if let lastTransactionId = transactionService._transactions.last?.id {
                    try await transactionService.deleteTransaction(id: lastTransactionId)
                }
            }
        }
    }
}
