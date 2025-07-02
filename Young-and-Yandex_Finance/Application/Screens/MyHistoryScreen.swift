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
            TransactionsListView(transactions: model.transactions, sum: model.sum, currencySymbol: model.currencySymbol)
        }
        .task {
            await model.updateData(from: model.getStartDateFrom, to: model.getEndDateTo, sort: model.sortSelection)
        }
        .onChange(of: model.sortSelection) {
            Task {
                await model.updateData(from: model.getStartDateFrom, to: model.getEndDateTo, sort: model.sortSelection)
            }
        }
        .onChange(of: model.dateTo) {
            Task {
                await model.updateData(from: model.getStartDateFrom, to: model.getEndDateTo, sort: model.sortSelection)
            }
        }
        .onChange(of: model.dateFrom) {
            Task {
                await model.updateData(from: model.getStartDateFrom, to: model.getEndDateTo, sort: model.sortSelection)
            }
        }
    }
    
    init(direction: Direction) {
        self.model = MyHistoryTransactionListViewModel(direction: direction)
    }
}
