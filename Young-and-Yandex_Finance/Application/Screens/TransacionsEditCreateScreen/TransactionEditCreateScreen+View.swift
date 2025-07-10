//
//  TransactionEditCreateScreen+View.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 10.07.2025.
//

import SwiftUI

extension TransacionsEditCreateScreen: View {
    
    var body: some View {
        NavigationStack {
            EmptyView()
            
        }
        .onDisappear {
            isOpen = false
        }
    }
}
