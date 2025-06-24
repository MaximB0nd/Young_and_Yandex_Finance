//
//  BankBalance.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 24.06.2025.
//

import SwiftUI

struct BankBalance: View {
    
    let balance: Decimal
    let currency: String
    
    var body: some View {
        Section {
            HStack {
                Text("💰")
                Text("Баланс")
                Spacer()
                Text("\(balance.formatted())")
                Text(currency)
            }
        }
    }
}
