//
//  SortSelection.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 21.06.2025.
//

import SwiftUI

struct SortSelection: View {
    
    @Binding var selection: SortSelectionType
    
    var body: some View {
        Picker("Сортировка", selection: $selection) {
            Text(SortSelectionType.none.rawValue)
                .tag(SortSelectionType.none)
            Text(SortSelectionType.date.rawValue)
                .tag(SortSelectionType.date)
            Text(SortSelectionType.price.rawValue)
                .tag(SortSelectionType.price)
        }
    }
}
