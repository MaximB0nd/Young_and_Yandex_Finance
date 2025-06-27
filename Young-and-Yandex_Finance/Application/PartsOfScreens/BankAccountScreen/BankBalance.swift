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
    
    @Environment(\.colorScheme) var colorScheme
    
    @State var isHidden: Bool = true
    
    var body: some View {
        Section {
            HStack {
                Text("💰")
                Text("Баланс")
                    .padding(.trailing, 15)
                HStack{
                    Spacer()
                    Text("\(balance.formatted())")
                    Text(currency)
                }
                .foregroundStyle(.white)
                .background(.white)
                .blur(radius: 5)
                
            }
        }
    }
}
