//
//  OutcomeFlow.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 18.06.2025.
//

import SwiftUI

struct OutcomeFlow: View {
    
    var body: some View {
        NavigationStack {
            OutcomeScreen()
                .navigationTitle(LocalizedStringKey("Расходы сегодня"))
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        NavigationLink {
                            MyHistoryFlow(direction: .outcome)
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
