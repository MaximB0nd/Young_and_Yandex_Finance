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
    let direction: Direction
    
    var body: some View {
        HStack {
            Text("Статья")
            Spacer()
            Picker("", selection: $selectedCategory) {
                
                Text("Не выбрано")
                    .tag(Optional<Category>.none)
                
                ForEach(allCategories as [Category?], id: \.self) { category in
                    Text(category?.name ?? "")
                        .tag(category)
                }
            }
        }
        .onAppear() {
            Task {
                self.allCategories = await CategoriesService.shared.getByDirection(direction)
            }
        }
    }
    
    init(selectedCategory: Binding<Category?>, direction: Direction) {
        self._selectedCategory = selectedCategory
        self.allCategories = []
        self.direction = direction
    }
}
