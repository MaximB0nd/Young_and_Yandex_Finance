//
//  BottomToolsIncomeFlow.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 11.07.2025.
//

import SwiftUI

struct BottomToolsIncomeFlow: View {
    
    @Binding var createIncome: Bool
    
    var body: some View {
        PlusButton(isPressed: $createIncome, direction: .income)
            .padding(26)
    }
}

