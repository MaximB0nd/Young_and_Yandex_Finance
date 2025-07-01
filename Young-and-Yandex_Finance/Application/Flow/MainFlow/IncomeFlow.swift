//
//  IncomeFlow.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 18.06.2025.
//

import SwiftUI

struct IncomeFlow: View {
    
    @StateObject var transactionService = TransactionsService.shared
    
    var body: some View {
        NavigationStack {
        
            IncomeScreen()
                .navigationTitle("Доходы сегодня")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink {
                            MyHistoryFlow(direction: .income)
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
