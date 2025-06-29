//
//  EditBankCurrency.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 27.06.2025.
//

import SwiftUI

struct EditBankCurrency: View {
    
    @State var isPresented = false
    @Binding var account: BankAccount
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        currencyLine
            .confirmationDialog("Валюта", isPresented: $isPresented) {
                EditBankCurrencyList(isPresented: $isPresented, selectedCurrency: Binding(get: {account.currency}, set: {account.currency = $0}))
            }
            .tint(.people)
    }
    
    var currencyLine: some View {
        HStack {
            Text("Валюта")
            button
        }
    }
    
    var button: some View {
        Button {
            isPresented.toggle()
        } label: {
            HStack{
                Spacer()
                Text("\(account.currencySymbol)")
                    .foregroundStyle(colorScheme == .dark ? .white : .black)
            }
        }
    }
}

