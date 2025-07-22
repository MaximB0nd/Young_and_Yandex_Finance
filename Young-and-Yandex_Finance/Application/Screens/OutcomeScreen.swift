//
//  OutcomeTransactionScreen.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 19.06.2025.
//

import SwiftUI

struct OutcomeScreen: View {
    
    @State var transactionService = TransactionsService.shared
    @State var model = TodayTransactionListViewModel.sharedOutcome
    
    var body: some View {
        Group {
            switch model.status {
            case .loaded:
                List {
                    TransactionsListView(
                        transactions: model.transactions,
                        sum: model.sum,
                        currencySymbol: model.currencySymbol
                    )
                }
            case .loading:
                ProgressView()
            }
        }
        .task {
            await model.updateTransactions()
        }
        .refreshable {
            Task {
                await model.updateTransactions()
            }
        }
    }
}


