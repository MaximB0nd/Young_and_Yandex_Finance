//
//  CategoryList.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 02.07.2025.
//

import SwiftUI

struct CategoryList: View {
    
    @Binding var searchText: String
    let model = CategoryViewModel.shared
    let categories: [Category]
    
    var body: some View {
        List {
            ForEach(categories) { category in
                CategoryView(category: category)
            }
        }
        .searchable(text: $searchText)
    }
}
