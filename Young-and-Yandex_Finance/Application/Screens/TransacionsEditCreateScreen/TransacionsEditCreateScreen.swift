//
//  TransacionsEditCreateScreen.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 10.07.2025.
//

import SwiftUI

struct TransacionsEditCreateScreen {
    
    @Binding var isOpen: Bool
    
    @State var model: any TransactionUpdater
    
    let isEdit: Bool
    let direction: Direction
    
    init(isOpen: Binding<Bool>, model: NewTransactionViewModel, direction: Direction) {
        
        self.model = model
        isEdit = false
        self._isOpen = isOpen
        self.direction = direction
    }
    
    init(transaction: Transaction, isOpen: Binding<Bool>, model: EditTransactionViewModel, direction: Direction) {
        
        self.model = model
        isEdit = true
        self._isOpen = isOpen
        self.direction = direction
    }
    
    
}
