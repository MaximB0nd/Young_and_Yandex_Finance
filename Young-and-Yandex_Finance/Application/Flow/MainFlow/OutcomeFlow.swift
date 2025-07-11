//
//  OutcomeFlow.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 18.06.2025.
//

import SwiftUI

struct OutcomeFlow: View {
    
    @State var createOutcome: Bool = false
    
    var body: some View {
        
        NavigationStack {
            ZStack(alignment: .bottomTrailing) {
                OutcomeScreen()
                    .navigationTitle(LocalizedStringKey("Расходы сегодня"))
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            clockButton
                        }
                    }
                BottomToolsOutcomeFlow()
            }
        }
        
    }
    
    var clockButton: some View {
        NavigationLink {
            MyHistoryFlow(direction: .outcome)
                .navigationTitle("Моя история")
            
        } label: {
            Image(systemName: "clock")
                .foregroundStyle(.people)
        }
    }
}
