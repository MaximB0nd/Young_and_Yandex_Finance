//
//  OutcomeFlow.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 18.06.2025.
//

import SwiftUI

struct OutcomeFlow: View {
    
    @State var createIncome: Bool = false
    
    var body: some View {
        
        if createIncome {
            CreateTransactionFlow(isOpen: $createIncome, direction: .outcome)
        } else {
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
}
