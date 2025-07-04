//
//  CategoryViewModel.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 02.07.2025.
//

import Foundation
import Ifrit

@Observable
final class CategoryViewModel: Sendable {
    
    static let shared = CategoryViewModel()
    
    var categories: [Category] = []
    let categotyService = CategoriesService.shared
    let fuse = Fuse()
    
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
        var allCat = await getCategories()
        let resultsIndexes = await fuse.search(text, in: allCat, by: \.propertiesCustomWeight).map({$0.index})
        
        for index in stride(from: allCat.count-1, through: 0, by: -1)  {
            if !resultsIndexes.contains(index) {
                allCat.remove(at: index)
            }
        }
        DispatchQueue.main.async {
            self.categories = allCat
        }
    }
}
