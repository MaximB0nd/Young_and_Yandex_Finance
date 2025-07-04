//
//  CategoryView.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 02.07.2025.
//

import SwiftUI

struct CategoryView: View {
    
    let category: Category
    
    var body: some View {
        HStack(spacing: 21) {
            emoji
            text
            Spacer()
        }
    }
    
    var emoji: some View {
        Text("\(category.emoji)")
            .font(.system(size: 10))
            .background(
                Circle()
                    .fill(Color.lightAccent)
                    .frame(width: 22, height: 22)
            )
    }
    
    var text: some View {
        Text(category.name)
            .font(.system(size: 17))
    }
}
