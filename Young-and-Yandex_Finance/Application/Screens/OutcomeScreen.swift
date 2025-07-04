//
//  OutcomeTransactionScreen.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 19.06.2025.
//

import SwiftUI

struct OutcomeScreen: View {
    
    @State var transactionService = TransactionsService.shared
    @State var model = TodayTransactionListViewModel(direction: .outcome)
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            List {
                TransactionsListView(transactions: model.transactions, sum: model.sum, currencySymbol: model.currencySymbol)
            }
            .task {
                await model.updateData()
            }
            .onChange(of: transactionService._transactions){
                Task {
                    await model.updateData()
                }
            }
            PlusButton(direction: .outcome)
                .padding(26)
        }
    }
}


