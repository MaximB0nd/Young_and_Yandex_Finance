//
//  MyHistoryScreen.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 21.06.2025.
//

import SwiftUI

struct MyHistoryScreen: View {
    
    let direction: Direction
    @ObservedObject var transactionService: TransactionsService
    @State var model: MyHistoryTransactionListViewModel
    
    @State var dateFrom: Date = DateConverter.previousMonth(date: .now)

    @State var dateTo: Date = DateConverter.endOfDay(.now)
    
    var body: some View {
        
        List{
            DateIntervalPicker(dateFrom: $dateFrom, dateTo: $dateTo)
            TransactionsListView(transactions: model.transactions, sum: model.sum, currencySymbol: model.currencySymbol)
        }.task {
            await model.updateData(from: dateFrom, to: dateTo)
        }
        .onChange(of: transactionService._transactions){
            Task {
                await model.updateData(from: dateFrom, to: dateTo)
            }
        }
        .onChange(of: dateTo){
            Task {
                await model.updateData(from: dateFrom, to: dateTo)
            }
        }
        .onChange(of: dateFrom){
            Task {
                await model.updateData(from: dateFrom, to: dateTo)
            }
        }
    }
    
    init(direction: Direction, transactionService: TransactionsService ) {
        self.direction = direction
        self.transactionService = transactionService
        self.model = .init(transactionService: transactionService, direction: direction)
    }
}
