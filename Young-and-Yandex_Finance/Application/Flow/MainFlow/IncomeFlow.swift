//
//  IncomeFlow.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 18.06.2025.
//

import SwiftUI

struct IncomeFlow: View {

    var body: some View {
        
            NavigationStack {
                ZStack(alignment: .bottomTrailing) {
                    IncomeScreen()
                        .navigationTitle("Доходы сегодня")
                        .toolbar {
                            ToolbarItem(placement: .topBarTrailing) {
                                clockButton
                            }
                        }
                    BottomToolsIncomeFlow()
                }
            }
    }
    
    var clockButton: some View {
        NavigationLink {
            MyHistoryFlow(direction: .income)
                .navigationTitle("Моя история")
        } label: {
            Image(systemName: "clock")
                .foregroundStyle(.people)
        }
    }
}
