//
//  IncomeScreen.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 21.06.2025.
//

import SwiftUI

struct IncomeScreen: View {
    
    @State var transactionService = TransactionsService.shared
    @State var model = TodayTransactionListViewModel.sharedIncome
    
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
            
            case .error:
                ErrorScreen()
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

