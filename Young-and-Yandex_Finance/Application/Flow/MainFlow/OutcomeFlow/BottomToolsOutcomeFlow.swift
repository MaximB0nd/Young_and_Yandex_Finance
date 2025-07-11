//
//  BottomToolsOutcomeFlow.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 11.07.2025.
//

import SwiftUI

struct BottomToolsOutcomeFlow: View {
    
    @Binding var createOutcome: Bool
    
    var body: some View {
        PlusButton(isPressed: $createOutcome, direction: .outcome)
            .padding(26)
    }
}
