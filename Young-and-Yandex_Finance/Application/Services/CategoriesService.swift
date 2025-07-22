//
//  CategoriesService.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 12.06.2025.
//

import Foundation

actor CategoriesService {
    
    static let shared = CategoriesService()
    private var _categories: [Category] = []
    
    var client = NetworkClient()
    let cacher = CategoryDataCache.shared
    
    private init () {}
    
    func loadCategories() async {
        do {
            // Internet
            _categories = try await client.category.request()
            await cacher.sync(_categories)
        } catch {
            switch error {
            case URLError.cancelled:
                break
            default:
                // Local
                try? await self.cacher.load()
                _categories = await self.cacher.categories
                ErrorLabelProvider.shared.showErrorLabel(with: error.localizedDescription)
            }
        }
        
    }
    
    func getAll() async -> [Category] {
        await loadCategories()
        return _categories
    }
    
    func getByDirection(_ direction: Direction) async -> [Category] {
        await loadCategories()
        return  _categories.filter({ $0.direction == direction })
    }
}

