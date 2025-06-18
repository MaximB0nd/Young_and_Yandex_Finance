//
//  MainFlow.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 18.06.2025.
//

import SwiftUI

enum TabBarFlow: Hashable {
    case income
    case outcome
    case account
    case articles
    case settings
}

struct MainFlow: View {
    
    @State var selection: TabBarFlow = .outcome
    
    var body: some View {
        TabView(selection: $selection) {
            
            Tab("Расходы", systemImage: "chart.bar.xaxis.ascending", value: .outcome) {
                OutcomeFlow()
            }
            
            Tab("Доходы", systemImage: "chart.bar.xaxis.ascending", value: .income) {
                IncomeFlow()
            }
            
            Tab("Счет", systemImage: "person.circle.fill", value: .account) {
                BankAccountFlow()
            }
            
            Tab("Статьи", systemImage: "book.fill", value: .articles) {
                ArticlesFlow()
            }
            
            Tab("Настройки", systemImage: "gear", value: .settings) {
                SettingsFlow()
            }
        }.animation(.bouncy, value: selection)
    }
}

#Preview {
    MainFlow()
}
