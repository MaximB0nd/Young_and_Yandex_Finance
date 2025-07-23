//
//  MemorySettingListItem.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 23.07.2025.
//

import SwiftUI

struct MemorySettingListItem: View {
    
    @State var pressed = false

    var body: some View {
        Button {
            pressed = true
        } label: {
            SettingListItem(resourceImage: .memorySetting, text: "Метод хранения данных")
                .contentShape(Rectangle())
        }
        .confirmationDialog("Хранилища данных", isPresented: $pressed) {
            EditMemoryTypeSelectionList()
        } message: {
            Text("Хранилища данных")
        }
    }
}
