//
//  IncomeFlow.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 18.06.2025.
//

import SwiftUI

struct IncomeFlow: View {
    
    @State var createIncome: Bool = false

    var body: some View {
        if createIncome {
            CreateTransactionFlow(isOpen: $createIncome, direction: .income)
                .transition(.move(edge: .bottom))
        } else {
            NavigationStack {
                ZStack(alignment: .bottomTrailing) {
                    IncomeScreen(createIncome: $createIncome)
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
                    BottomToolsIncomeFlow(createIncome: $createIncome)
                }
            }
        }
        
        
        
    }
}
