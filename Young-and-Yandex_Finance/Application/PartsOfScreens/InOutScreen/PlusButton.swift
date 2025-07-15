//
//  PlusButton.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 22.06.2025.
//

import SwiftUI

struct PlusButton: View {
    
    @State var isPressed = false
    
    let direction: Direction
    let transactionService = TransactionsService.shared
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        Button {
            isPressed.toggle()
        } label: {
            ZStack {
                Circle()
                    .fill(.accent)
                    .frame(width: 56, height: 56)
                
                Image(systemName: "plus")
                    .foregroundColor(colorScheme == .dark ? .black : .white)
                    .font(.system(size: 20))
            }
        }
        .buttonStyle(PlainButtonStyle())
        .fullScreenCover(isPresented: $isPressed) {
            TransacionsEditCreateScreen(direction: direction)
        }
    }
}
