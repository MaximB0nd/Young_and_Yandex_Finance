//
//  TransactionsListView.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 18.06.2025.
//

import SwiftUI

struct TransactionsListView: View {
    
    @ObservedObject var service: TransactionsService
    @State var model: TransactionListViewModelProtocol
    let direction: Direction
    
    var body: some View {
            total
            
            Section(header: Text("Операции")) {
                ForEach(model.transactions) { transaction in
                    NavigationLink(value: transaction.id) {
                        TransactionView(transaction: transaction)
                    }
                }
            
        }.task {
            await updateData()
        }
        .onChange(of: service._transactions){
            Task {
                await updateData()
            }
        }
    }
    
    var total: some View {
        HStack {
            Text("Всего")
            Spacer()
            Text("\(model.sum.formatted()) \(model.currencySymbol)")
        }
    }
    
    func updateData() async {
        await model.getTransactions(by: direction)
        await model.getSum()
        await model.getCurrencySymbol()
    }
}


