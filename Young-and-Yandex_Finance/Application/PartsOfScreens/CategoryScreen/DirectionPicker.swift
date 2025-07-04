//
//  DirectionPicker.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 02.07.2025.
//

import SwiftUI

struct DirectionPicker: View {
    
    @Binding var selectedDirection: Direction
    
    var body: some View {
        Picker("", selection: $selectedDirection) {
            ForEach(Direction.allCases) { direction in
                Text(direction.rawValue.capitalized)
                    .tag(direction)
            }
        }
        .pickerStyle(.palette)

    }
}

#Preview {
    
    @Previewable @State var selectedDirection: Direction = .income
    
    DirectionPicker(selectedDirection: $selectedDirection)
}
