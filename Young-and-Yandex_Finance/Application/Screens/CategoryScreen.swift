//
//  CategoryScreen.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 02.07.2025.
//

import SwiftUI

struct CategoryScreen: View {
    
    @State var model = CategoryViewModel.shared
    @State var searchText: String = ""
    
    var body: some View {
        VStack (spacing: 0){
            CategoryList(searchText: $searchText, categories: model.categories)
        }
        .task {
            await model.onSearchTextChanged(searchText)
        }
        .onChange(of: searchText) {
            Task {
                await model.onSearchTextChanged(searchText)
            }
        }
    }
}
