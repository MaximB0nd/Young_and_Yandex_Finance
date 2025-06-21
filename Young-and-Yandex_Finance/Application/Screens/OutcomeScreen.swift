//
//  OutcomeTransactionScreen.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 19.06.2025.
//

import SwiftUI

struct OutcomeScreen: View {
    
    @ObservedObject var transactionService: TransactionsService
    @State var model: TodayTransactionListViewModel
    
    var body: some View {
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
    }
    
    init(transactionService: TransactionsService) {
        self.transactionService = transactionService
        self.model = .init(transactionService: transactionService, direction: .outcome)
    }
    
    
}


