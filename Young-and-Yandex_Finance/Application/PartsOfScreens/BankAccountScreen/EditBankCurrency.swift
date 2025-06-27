//
//  EditBankCurrency.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 27.06.2025.
//

import SwiftUI

struct EditBankCurrency: View {
    
    @State var isPresented = false
    @Binding var currency: String
    
    var body: some View {
        currencyLine
            .sheet(isPresented: $isPresented){
                
            }
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
            Spacer()
            Text("")
        }
    }
}

