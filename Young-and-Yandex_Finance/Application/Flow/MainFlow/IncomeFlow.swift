//
//  IncomeFlow.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 18.06.2025.
//

import SwiftUI

struct IncomeFlow: View {
    
    @ObservedObject var transactionService: TransactionsService
    
    var body: some View {
        NavigationStack {
        
            IncomeScreen(transactionService: transactionService)
                .navigationTitle("Доходы сегодня")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink {
                            MyHistoryFlow(direction: .income, transactionService: transactionService)
                                .navigationTitle("Моя история")
                            
                        } label: {
                            Image(systemName: "clock")
                                .foregroundStyle(.people)
                        }
                    }
                }
            
            
        }
    }
}
