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
            
            Tab(value: .outcome) {
                OutcomeFlow()
            } label: {
                outcomeTabItem
            }
            
            Tab(value: .income) {
                IncomeFlow()
            } label: {
                incomeTabItem
            }
            
            Tab(value: .account) {
                BankAccountFlow()
            } label: {
                accountTabItem
            }
            
            Tab(value: .articles) {
                ArticlesFlow()
            } label: {
                articleTabItem
            }
            
            
            Tab(value: .settings) {
                SettingsFlow()
            } label: {
                settingsTabItem
            }
        }
    }
    
    var incomeTabItem: some View {
        VStack {
            Text("Доходы")
            Image("ChartUp")
        }
    }
    
    var outcomeTabItem: some View {
        VStack {
            Text("Расходы")
            Image("ChartDown")
        }
    }
    
    var accountTabItem: some View {
        VStack {
            Text("Cчет")
            Image("Account")
        }
    }
    
    var articleTabItem: some View {
        VStack {
            Text("Статьи")
            Image("Articles")
        }
    }
    
    var settingsTabItem: some View {
        VStack {
            Text("Настройки")
            Image("Settings")
        }
    }
}
