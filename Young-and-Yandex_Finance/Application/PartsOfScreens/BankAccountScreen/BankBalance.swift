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
        Section {
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
                .foregroundStyle(isHidden ? .white : .black)
                .background(isHidden ? .white : .clear)
                .clipShape(.capsule)
                .blur(radius: isHidden ? 9 : 0)
                .transition(.opacity)
                .onReceive(NotificationCenter.default.publisher(for: .shakeNotification)) {_ in
                    withAnimation(.bouncy) {
                        isHidden.toggle()
                    }
                }
                .onTapGesture {
                    withAnimation(.bouncy) {
                        isHidden.toggle()
                    }
                }
            }
        }
    }
}
