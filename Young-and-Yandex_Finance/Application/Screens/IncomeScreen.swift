//
//  IncomeScreen.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 21.06.2025.
//

import SwiftUI

struct IncomeScreen: View {
    
    @State var transactionService = TransactionsService.shared
    @State var model = TodayTransactionListViewModel(direction: .income)
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            List {
                TransactionsListView(
                    transactions: model.transactions,
                    sum: model.sum,
                    currencySymbol: model.currencySymbol
                )
            }
            .task {
                print("task")
                await model.updateData()
            }
            .onChange(of: transactionService._transactions){
                print("change")
                Task {
                    await model.updateData()
                }
            }
            PlusButton(direction: .income)
                .padding(26)
        }
    }
}

