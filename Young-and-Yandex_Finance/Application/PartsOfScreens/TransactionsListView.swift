//
//  TransactionsListView.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 18.06.2025.
//

import SwiftUI

struct TransactionsListView: View {
    
    let transactions: [Transaction]
    let sum: Decimal
    let currencySymbol: String
    
    var body: some View {
            total
            
            Section(header: Text("Операции")) {
                ForEach(transactions) { transaction in
                    NavigationLink(value: transaction.id) {
                        TransactionView(transaction: transaction)
                    }
                }
        }
    }
    
    var total: some View {
        HStack {
            Text("Всего")
            Spacer()
            Text("\(sum.formatted()) \(currencySymbol)")
        }
    }
}


