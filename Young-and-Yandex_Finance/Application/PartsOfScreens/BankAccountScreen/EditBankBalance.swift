//
//  EditBankBalance.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 24.06.2025.
//

import SwiftUI

struct EditBankBalance: View {
    
    @Binding var balance: Decimal
    @State var text: String = ""
    
    var body: some View {
        HStack {
            Text("💰")
            Text("Баланс")
            Spacer()
            TextField(text: $text) {}
                .keyboardType(.numbersAndPunctuation)
                .submitLabel(.done)
                .multilineTextAlignment(.trailing)
                .onChange(of: text) { _, newValue in
                    let val = newValue.convertToDecimal
                    text = val
                    balance = Decimal(string: val, locale: Locale.current) ?? 0
                }
        }
    }
    
    init(balance: Binding<Decimal>) {
        self._balance = balance
        _text = .init(initialValue: balance.wrappedValue.description)
    }
}
