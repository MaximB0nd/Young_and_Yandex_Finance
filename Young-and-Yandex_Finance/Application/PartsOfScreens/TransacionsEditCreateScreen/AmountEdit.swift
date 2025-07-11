//
//  AmountEdit.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 11.07.2025.
//

import SwiftUI

struct AmountEdit: View {
    
    @Binding var amount: Decimal?
    @Binding var textAmount: String
    let currency: String
    
    var body: some View {
        HStack {
            Text("Сумма")
            TextField("Cумма", text: $textAmount)
                .multilineTextAlignment(.trailing)
            Text(currency)
        }
    }
}

