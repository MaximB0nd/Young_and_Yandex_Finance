//
//  TransactionView+View.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 19.06.2025.
//

import SwiftUI

extension TransactionView: View {
    var body: some View {
        HStack(spacing: 21) {
            emoji
            text
            Spacer()
            amountText
        }
    }
    
    var emoji: some View {
        Text("\(transaction.category.emoji)")
            .font(.system(size: 10))
            .background(
                Circle()
                    .fill(Color("EmojiBackground"))
                    .frame(width: 22, height: 22)
            )
    }
    
    var text: some View {
        VStack(alignment: .leading) {
            Text(transaction.category.name)
                .font(.system(size: 17))
            if let comment = transaction.comment {
                Text(comment)
                    .font(.system(size: 13))
                    .foregroundStyle(.gray)
            }
        }
    }
    
    var amountText: some View {
        Text("\(transaction.amount.formatted()) \(transaction.account.currencySymbol)" )
    }
}

extension Decimal {
    func formatted(decimalPlaces: Int = 2) -> String {
            let number = NSDecimalNumber(decimal: self)
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            return formatter.string(from: number) ?? "\(self)"
    }
}

#Preview {
    let transaction = Transaction(
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
    )
    
    List {
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        NavigationLink(destination: {Text("Hello")}){  TransactionView(transaction: transaction)
        }
        Spacer()
    }.offset(y: 20)
    
}
