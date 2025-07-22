//
//  CategoryViewModel.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 02.07.2025.
//

import Foundation

@Observable
final class CategoryViewModel {
    
    static let shared = CategoryViewModel()
    
    var categories: [Category] = []
    let categotyService = CategoriesService.shared
    
    var status: ShowStatus = .loading
    
    private init() {
        Task {
            await getCategories()
        }
    }
    
    @discardableResult
    func getCategories() async -> [Category] {
        let result = await categotyService.getAll()
        
        categories = result
        status = .loaded
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
