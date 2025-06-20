//
//  OutcomeTransactionScreen.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 19.06.2025.
//

import SwiftUI

struct OutcomeScreen: View {
    
    @ObservedObject var transactionService: TransactionsService
    
    var body: some View {
        TransactionsListView(service: transactionService, model: TransactionListViewModel(transactionService: transactionService), direction: .outcome)
    }
}


