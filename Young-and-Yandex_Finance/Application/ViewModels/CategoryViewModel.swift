//
//  CategoryViewModel.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 02.07.2025.
//

import Foundation

@Observable
final class CategoryViewModel: Sendable {
    
    static let shared = CategoryViewModel()
    
    var categories: [Category] = []
    let categotyService = CategoriesService.shared
    
    init() {
        Task {
            categories = await categotyService.getByDirection(.income)
        }
    }
    
    @discardableResult
    func getCategories() async -> [Category] {
        categories = await categotyService.getAll()
        return categories
    }
    
    func onSearchTextChanged(_ text: String) async {
        if text.isEmpty {
            await getCategories()
        } else {
            await fuzzySearch(for: text)
        }
    }
    
    func fuzzySearch(for text: String) async {
        categories = await getCategories().fuzzySearch(input: text)
    }
}
