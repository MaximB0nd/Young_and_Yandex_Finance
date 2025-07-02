//
//  CategoryList.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 02.07.2025.
//

import SwiftUI

struct CategoryList: View {
    
    @State var searchText: String = ""
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


