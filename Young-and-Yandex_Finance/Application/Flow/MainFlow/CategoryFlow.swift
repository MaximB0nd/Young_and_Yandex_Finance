//
//  ArticlesFlow.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 18.06.2025.
//

import SwiftUI

struct CategoryFlow: View {
    var body: some View {
        NavigationStack {
            CategoryScreen()
                .navigationTitle(Text("Мои статьи"))
        }
    }
}
