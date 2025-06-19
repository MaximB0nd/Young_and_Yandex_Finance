//
//  TransactionsListView.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 18.06.2025.
//

import SwiftUI

struct TransactionsListView: View {
    
    var transactions: [Transaction]
    let direction: Direction
    
    var body: some View {
        List {
            Section(header: Text("Операции")) {
                ForEach(transactions.filter({$0.category.direction == direction})) { transaction in
                    NavigationLink(value: transaction.id) {
                        TransactionView(transaction: transaction)
                    }
                }
            }
        }
    }
}

#Preview {
    
    let transaction = [Transaction(
        id: 1,
        account: .init(
            id: 1,
            name: "amx",
            balance: 1.2,
            currency: "RUB"
        ),
        category: .init(
            id: 1,
            name: "На собачку",
            emoji: "🐕",
            direction: .income
        ),
        amount: 100000,
        transactionDate: .now,
        comment: "Энни",
        createdAt: .now,
        updatedAt: .now
    ), Transaction(
        id: 1,
        account: .init(
            id: 1,
            name: "amx",
            balance: 1.2,
            currency: "RUB"
        ),
        category: .init(
            id: 1,
            name: "На собачку",
            emoji: "🐕",
            direction: .income
        ),
        amount: 100000,
        transactionDate: .now,
        comment: "Энни",
        createdAt: .now,
        updatedAt: .now
    )]
    
    TransactionsListView(transactions: transaction, direction: .income)
}

