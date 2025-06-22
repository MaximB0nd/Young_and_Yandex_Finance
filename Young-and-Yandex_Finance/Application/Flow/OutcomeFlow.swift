//
//  OutcomeFlow.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 18.06.2025.
//

import SwiftUI

struct OutcomeFlow: View {
    
    @ObservedObject var transactionService: TransactionsService
    
    var body: some View {
        
        NavigationStack {
            OutcomeScreen(transactionService: transactionService)
                .navigationTitle(LocalizedStringKey("Расходы сегодня"))
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink {
                            MyHistoryFlow(direction: .outcome, transactionService: transactionService)
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
