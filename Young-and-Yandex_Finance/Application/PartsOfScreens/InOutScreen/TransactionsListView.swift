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
    
    @State var selectedTransaction: Transaction? = nil
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Group {
            
            Section {
                total
            }
           
            
            Section(header: Text("Операции")) {
                
                ForEach(transactions) { transaction in
                    Button {
                        selectedTransaction = transaction
                    } label: {
                        TransactionView(transaction: transaction)
                            .contentShape(Rectangle())
                            .foregroundStyle(colorScheme == .light ? .black : .white)
                    }
                    .fullScreenCover(item: $selectedTransaction) { transaction in
                        TransacionsEditCreateScreen(transaction: transaction)
                    }
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


