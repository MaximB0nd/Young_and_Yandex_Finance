//
//  CreateTransactionFlow.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 10.07.2025.
//

import SwiftUI

struct CreateTransactionFlow: View {
    
    @Binding var isOpen: Bool
    let direction: Direction
    
    var body: some View {
        NavigationStack {
            TransacionsEditCreateScreen(direction: direction, isOpen: $isOpen)
        }
        .transition(.move(edge: .bottom))
    }
}
