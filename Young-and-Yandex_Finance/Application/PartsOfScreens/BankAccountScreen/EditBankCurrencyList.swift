//
//  EditBankCurrencyList.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 27.06.2025.
//

import SwiftUI

struct EditBankCurrencyList: View {
    
    @Binding var isPresented: Bool
    @Binding var selectedCurrency: String
    
    var currencies: [String: String] = [
        "RUB": "₽",
        "EUR": "€",
        "USD": "$"
    ]
    
    var body: some View {
        Group{
            ForEach(currencies.keys.sorted(), id: \.self) { key in
                Button {
                    selectedCurrency = key
                } label: {
                    Text("\(key)  \(currencies[key] ?? "")")
                }
            }
        }
    }
}


