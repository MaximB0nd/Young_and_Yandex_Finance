//
//  Currency.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 24.06.2025.
//

import SwiftUI

struct BankCurrency: View {
    
    let currency: String
    
    var body: some View {
        HStack {
            Text("Валюта")
            Spacer()
            Text(currency)
        }
    }
}

