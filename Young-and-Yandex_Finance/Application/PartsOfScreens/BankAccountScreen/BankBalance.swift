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
    
    @State var isHidden: Bool = true
    
    var body: some View {
        HStack {
            Text("💰")
            Text("Баланс")
                .padding(.trailing, 15)
                .foregroundStyle(.black)
            HStack{
                Spacer()
                Text("\(balance.formatted())")
                Text(currency)
            }
            .foregroundStyle(.black)
            .spoiler(isOn: $isHidden)
            .onReceive(NotificationCenter.default.publisher(for: .shakeNotification)) {_ in
                withAnimation(.bouncy) {
                    isHidden.toggle()
                }
            }
        }
        .onDisappear {
            isHidden = true
        }
    }
}
