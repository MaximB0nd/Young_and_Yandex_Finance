//
//  MyHistoryFlow.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 22.06.2025.
//

import SwiftUI

struct MyHistoryFlow: View {
    let direction: Direction
    @State var transactionService = TransactionsService.shared
    @State var selectedTransaction: Transaction?
    var body: some View {
        MyHistoryScreen(direction: direction)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        AnalyticsScreenUIKit(selectedTransaction: $selectedTransaction, direction: direction)
                            .navigationTitle("Анализ")
                            .fullScreenCover(item: $selectedTransaction) { transaction in
                                TransacionsEditCreateScreen(transaction: transaction)
                            }
                    } label: {
                        Image(systemName: "document")
                    }.tint(.people)
                }
            }
    }
}
