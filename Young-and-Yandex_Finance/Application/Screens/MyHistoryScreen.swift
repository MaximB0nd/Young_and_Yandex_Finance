//
//  MyHistoryScreen.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 21.06.2025.
//

import SwiftUI

struct MyHistoryScreen: View {
    
    @StateObject var transactionService = TransactionsService.shared
    
    @State var model: MyHistoryTransactionListViewModel
    @State var dateFrom: Date = DateConverter.previousMonth(date: .now)
    @State var dateTo: Date = DateConverter.endOfDay(.now)
    @State var sortSelection: SortSelectionType = .none
    
    var body: some View {
        
        List{
            DateIntervalPicker(model: model, dateFrom: $dateFrom, dateTo: $dateTo)
            SortSelection(selection: $sortSelection)
            TransactionsListView(transactions: model.transactions, sum: model.sum, currencySymbol: model.currencySymbol)
        }
        .task {
            await model.updateData(from: dateFrom, to: dateTo, sort: sortSelection)
        }
        .onChange(of: transactionService._transactions){
            Task {
                await model.updateData(from: dateFrom, to: dateTo, sort: sortSelection)
            }
        }
        .onChange(of: dateTo){
            Task {
                await model.updateData(from: dateFrom, to: dateTo, sort: sortSelection)
            }
        }
        .onChange(of: dateFrom){
            Task {
                await model.updateData(from: dateFrom, to: dateTo, sort: sortSelection)
            }
        }
        .onChange(of: sortSelection) {
            Task {
                await model.updateData(from: dateFrom, to: dateTo, sort: sortSelection)
            }
        }
    }
    
    init(direction: Direction) {
        self.model = .init(direction: direction)
    }
}
