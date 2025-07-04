//
//  CategoryViewModel.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 02.07.2025.
//

import Foundation

@Observable
class CategoryViewModel {
    
    static let shared = CategoryViewModel()
    
    var categories: [Category] = []
    let categotyService = CategoriesService.shared
    
    init() {
        Task {
            categories = await categotyService.getByDirection(.income)
        }
    }
    
    func getCategories() async {
        categories = await categotyService.getAll()
    }
    
    func onSearchTextChanged(_ text: String) async {
        if text.isEmpty {
            await getCategories()
        } else {
            await fuzzySearch(for: text)
        }
    }
    
    func fuzzySearch(for text: String) async {
        categories = await categotyService.getAll().fuzzySearch(searchString: text) ?? []
    }
}
