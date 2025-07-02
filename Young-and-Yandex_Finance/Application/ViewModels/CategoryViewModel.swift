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
    
    func getCategories(by direction: Direction) async {
        categories = await categotyService.getByDirection(direction)
    }
    
    func onSearchTextChanged(_ text: String, orBy direction: Direction) async {
        text.isEmpty ? await fuzzySearch(for: text) : await categotyService.getByDirection(direction)
    }
    
    func fuzzySearch(for text: String) async {
        
    }
}
