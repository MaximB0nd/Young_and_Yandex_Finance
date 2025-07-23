//
//  SettingsFlow.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 18.06.2025.
//

import SwiftUI

struct SettingsFlow: View {
    var body: some View {
        NavigationStack {
            SettingsScreen()
                .navigationTitle(Text("Настройки"))
        }
    }
}
