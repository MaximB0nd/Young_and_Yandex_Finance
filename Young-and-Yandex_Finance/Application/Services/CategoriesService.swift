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
    
    private init () {}
    
    func load() async throws {
        _categories = try await client.category.request()
    }
    
    func getAll() async -> ResponceResult<[Category], Error> {
        var result = ResponceResult<[Category], Error>()
        
        do {
            try await load()
        } catch {
            result.error = error
        }
        result.success = _categories
        
        return result
    }
    
    func getByDirection(_ direction: Direction) async -> ResponceResult<[Category], Error> {
        var result = ResponceResult<[Category], Error>()
        
        do {
            try await load()
        } catch {
            result.error = error
        }
        result.success = _categories.filter({ $0.direction == direction })
        
        return result
    }
}

