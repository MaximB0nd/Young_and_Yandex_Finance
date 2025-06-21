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
    
    @State var dateFrom: Date = DateConverter.previousMonth(date: .now)

    @State var dateTo: Date = DateConverter.endOfDay(.now)
    
    var body: some View {
        
        List{
            DateIntervalPicker(dateFrom: $dateFrom, dateTo: $dateTo)
            TransactionsListView(service: transactionService, model: TodayTransactionListViewModel(transactionService: transactionService), direction: direction)
            
        
        }
    }
}
