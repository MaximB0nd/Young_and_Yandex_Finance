//
//  IncomeScreen.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 21.06.2025.
//

import SwiftUI

struct IncomeScreen: View {
    
    @ObservedObject var transactionService: TransactionsService
    
    var body: some View {
        TransactionsListView(service: transactionService, model: TransactionListViewModel(transactionService: transactionService), direction: .income)
    }
}

