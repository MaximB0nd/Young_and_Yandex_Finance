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
        for i in 0..<100 {
            categories.append(.init(id: i, name: "Test \(i)", emoji: Character(String(i)), direction: i%2==0 ? .outcome : .outcome))
        }
        _categories = categories
    }
    
    func gelAll() async -> [Category] {
        return _categories
    }
    
    func getByDirection(_ direction: Direction) async -> [Category] {
        return _categories.filter({ $0.direction == direction })
    }
}

