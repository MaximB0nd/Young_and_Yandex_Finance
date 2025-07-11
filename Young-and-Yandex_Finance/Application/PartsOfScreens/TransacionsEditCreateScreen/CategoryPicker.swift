//
//  CategoryPicker.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 11.07.2025.
//

import SwiftUI

struct CategoryPicker: View {
    
    @Binding var selectedCategory: Category?
    @State var allCategories: [Category]
    
    var body: some View {
        HStack {
            Text("Статья")
            Spacer()
            Picker("", selection: $selectedCategory) {
                
                Text("Не выбрано").tag(Optional<Category>.none)
                
                ForEach(allCategories) { category in
                    Text(category.name).tag(category)
                }
            }
        }
        .task {
            self.allCategories = await CategoriesService.shared.getAll()
        }
    }
    
    init(selectedCategory: Binding<Category?>) {
        self._selectedCategory = selectedCategory
        self.allCategories = []
    }
}
