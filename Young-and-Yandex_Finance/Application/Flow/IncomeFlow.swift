//
//  IncomeFlow.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 18.06.2025.
//

import SwiftUI

struct IncomeFlow: View {
    
    @ObservedObject var transactionService: TransactionsService
    
    var body: some View {
        NavigationStack {
            IncomeScreen(transactionService: transactionService)
                .navigationTitle("Доходы сегодня")
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
                category:
                        .init(
                            id: 1,
                            name: "Inding",
                            emoji: "🐕",
                            direction: .income),
                amount: 100,
                transactionDate: .now)
            }
        }
    }
    
    var minusButton: some View {
        Button("-"){
            Task {
                if let lastTransactionId = transactionService._transactions.first(where: {$0.category.direction == .income})?.id {
                    try await transactionService.deleteTransaction(id: lastTransactionId)
                }
            }
        }
    }
}
