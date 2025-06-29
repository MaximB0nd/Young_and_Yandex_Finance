//
//  MyHistoryFlow.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 22.06.2025.
//

import SwiftUI

struct MyHistoryFlow: View {
    
    let direction: Direction
    @ObservedObject var transactionService: TransactionsService
    
    var body: some View {
        MyHistoryScreen(direction: direction, transactionService: transactionService)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        
                    } label: {
                        Image(systemName: "document")
                    }.tint(.people)
                }
            }
            
    }
}
