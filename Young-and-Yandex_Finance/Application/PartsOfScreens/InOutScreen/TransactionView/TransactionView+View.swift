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
                    .fill(Color.lightAccent)
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
