//
//  CategoryViewModel.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 02.07.2025.
//

import Foundation

@Observable
class CategoryViewModel {
    
    var categories: [Category] = []
    let categotyService = CategoriesService.shared
    
    init() {
        Task {
            categories = await categotyService.getAll()
        }
    }
    
    func getCategories(by direction: Direction) async -> [Category] {
        return await categotyService.getByDirection(direction)
    }
    
    func getCategoties(by name: String) async -> [Category] {
        return [categories[0]]
    }
}
