//
//  EditBankBalance.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 24.06.2025.
//

import SwiftUI

struct EditBankBalance: View {
    
    @State var balance: Decimal
    
    var body: some View {
        
            HStack {
                Text("💰")
                Text("Баланс")
                Spacer()
                TextField(value: $balance, format: .number) {}
                    .keyboardType(.numbersAndPunctuation)
                    .onSubmit {}
                    .submitLabel(.done)
                    .multilineTextAlignment(.trailing)
            }
            
    }
}
#Preview {
    EditBankBalance(balance: 100)
}
