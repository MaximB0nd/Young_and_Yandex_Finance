//
//  CategoryScreen.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 02.07.2025.
//

import SwiftUI

struct CategoryScreen: View {
    
    @State var model = CategoryViewModel.shared
    @State var direction: Direction = .income
    
    var body: some View {
        VStack{
            DirectionPicker(selectedDirection: $direction)
            CategoryList(categories: model.categories)
        }
        .onChange(of: direction) {
            Task {
                await model.getCategories(by: direction)
            }
        }
    }
}
