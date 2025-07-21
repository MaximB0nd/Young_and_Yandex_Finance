//
//  MyHistoryScreen.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 21.06.2025.
//

import SwiftUI

struct MyHistoryScreen: View {
    
    @State var model: MyHistoryTransactionListViewModel
    
    var body: some View {
        
        List{
            DateIntervalPicker(dateFrom: $model.dateFrom, dateTo: $model.dateTo)
            SortSelection(selection: $model.sortSelection)
            switch model.status {
            case .loading:
                ProgressView()
            case .loaded:
                TransactionsListView(transactions: model.transactions, sum: model.sum, currencySymbol: model.currencySymbol)
            case .error:
                ErrorScreen()
                    
            }
            
        }
        .task {
            await model.updateTransactions()
        }
        .onChange(of: model.sortSelection) {
            Task {
                await model.updateTransactions()
            }
        }
        .onChange(of: model.dateTo) {
            Task {
                await model.presaveDateTo()
                await model.updateTransactions()
                
            }
        }
        .onChange(of: model.dateFrom) {
            Task {
                await model.presaveDateFrom()
                await model.updateTransactions()
                
            }
        }
        .refreshable {
            Task {
                await model.updateTransactions()
            }
        }
    }
    
    init(direction: Direction) {
        self.model = MyHistoryTransactionListViewModel(direction: direction)
    }
}
