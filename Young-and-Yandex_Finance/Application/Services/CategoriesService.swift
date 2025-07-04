//
//  CategoriesService.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 12.06.2025.
//

import Foundation

@Observable
final class CategoriesService {
    
    static let shared = CategoriesService()
    
    private var _categories: [Category]
    
    private init () {
        var categories = [Category]()
        categories.append(.init(id: 1, name: "Аренда квартиры", emoji: "🏠", direction: .outcome))
        categories.append(.init(id: 2, name: "Одежда", emoji: "👔", direction: .outcome))
        categories.append(.init(id: 3, name: "На собачку", emoji: "🐕", direction: .outcome))
        categories.append(.init(id: 4, name: "Ремонт квартиры", emoji: "🔨", direction: .outcome))
        categories.append(.init(id: 5, name: "Ремонт дома", emoji: "🏠", direction: .outcome))
        categories.append(.init(id: 6, name: "Зарплата", emoji: "💰", direction: .income))
        categories.append(.init(id: 7, name: "Сдача квартиры", emoji: "🏠", direction: .income))
        _categories = categories
    }
    
    func getAll() async -> [Category] {
        return _categories
    }
    
    func getByDirection(_ direction: Direction) async -> [Category] {
        return _categories.filter({ $0.direction == direction })
    }
}

