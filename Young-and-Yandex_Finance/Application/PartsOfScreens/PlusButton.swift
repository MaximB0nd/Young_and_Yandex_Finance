//
//  PlusButton.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 22.06.2025.
//

import SwiftUI

struct PlusButton: View {
    
    let direction: Direction
    @ObservedObject var transactionService: TransactionsService
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button {
            Task{
                try! await transactionService.createTransaction(
                account:
                        .init(
                            id: 1,
                            name: "Max",
                            balance: 1000,
                            currency: "RUB"),
                category:
                        .init(
                            id: 1,
                            name: "Inding",
                            emoji: "🐕",
                            direction: direction),
                amount: Decimal(Int.random(in: 1...10000)) + 0.7777777777,
                transactionDate: Calendar.current.date(byAdding: .day, value: Int.random(in: -2...2), to: .now)!)
            }
        } label: {
            ZStack {
                Circle()
                    .fill(.accent)
                    .frame(width: 56, height: 56)
                
                Image(systemName: "plus")
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                    .font(.system(size: 20))
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}
