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
    
    @Binding var createIncome: Bool
    
    var body: some View {
        List {
            TransactionsListView(
                transactions: model.transactions,
                sum: model.sum,
                currencySymbol: model.currencySymbol
            )
        }
        .task {
            await model.updateTransactions()
        }
        .onChange(of: transactionService._transactions){
            Task {
                await model.updateTransactions()
            }
        }
        
        
    }
}

