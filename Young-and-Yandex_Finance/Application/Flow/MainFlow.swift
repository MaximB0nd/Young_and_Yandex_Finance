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
    @StateObject var transactionService = TransactionsService()
    
    var body: some View {
        TabView(selection: $selection) {
            
            Tab(value: .outcome) {
                OutcomeFlow(transactionService: transactionService)
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
            Image(selection == .income ? "ChartUpGreen" : "ChartUpGray")
        }
    }
    
    var outcomeTabItem: some View {
        VStack {
            Text("Расходы")
            Image(selection == .outcome ? "ChartDownGreen" : "ChartDownGray")
        }
    }
    
    var accountTabItem: some View {
        VStack {
            Text("Cчет")
            Image(selection == .account ? "AccountGreen" : "AccountGray")
        }
    }
    
    var articleTabItem: some View {
        VStack {
            Text("Статьи")
            Image(selection == .articles ? "ArticlesGreen" : "ArticlesGray")
        }
    }
    
    var settingsTabItem: some View {
        VStack {
            Text("Настройки")
            Image(selection == .settings ? "SettingsGreen" : "SettingsGray")
        }
    }
}
