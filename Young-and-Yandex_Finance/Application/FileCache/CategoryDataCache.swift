//
//  CategoryDataCache.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 22.07.2025.
//

import Foundation
import SwiftData

actor CategoryDataCache {
    static var shared = CategoryDataCache()
    
    private let modelContainer: ModelContainer
    private let context: ModelContext
    
    private init() {
        let schema = Schema([CategoryDataModel.self])
        let config = ModelConfiguration("Categories", schema: schema)
        let container = try! ModelContainer(for: schema, configurations: config)
        self.modelContainer = container
        self.context = ModelContext(container)
    }
    
    private var _categories: [Category] = []
    
    var categories: [Category] {
        _categories
    }
    
    func load() async throws {
        let descriptor = FetchDescriptor<CategoryDataModel>()
        self._categories = try self.context.fetch(descriptor).map(\.category)
    }
    
    func sync(_ categories: [Category]) async {
        do {
            let descriptor = FetchDescriptor<CategoryDataModel>()
            let models = try self.context.fetch(descriptor)
            models.forEach { context.delete($0) }
        } catch {}
        
        categories.forEach {
            context.insert(CategoryDataModel(from: $0))
        }
        
        try? context.save()
    }
}
