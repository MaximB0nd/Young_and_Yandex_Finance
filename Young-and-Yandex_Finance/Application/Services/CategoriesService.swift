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
        
        let categoryCreation = [
            Category(id: 1, name: "Зарплата", emoji: "💰", direction: .income),
            Category(id: 2, name: "Фриланс", emoji: "💻", direction: .income),
            Category(id: 3, name: "Дивиденды", emoji: "📈", direction: .income),
            Category(id: 4, name: "Подарки", emoji: "🎁", direction: .income),
            Category(id: 5, name: "Возврат долга", emoji: "↩️", direction: .income),
            
            Category(id: 6, name: "Аренда квартиры", emoji: "🏠", direction: .outcome),
            Category(id: 7, name: "Продукты", emoji: "🛒", direction: .outcome),
            Category(id: 8, name: "Транспорт", emoji: "🚗", direction: .outcome),
            Category(id: 9, name: "Кафе/Рестораны", emoji: "🍔", direction: .outcome),
            Category(id: 10, name: "Одежда", emoji: "👕", direction: .outcome),
            Category(id: 11, name: "Здоровье", emoji: "⚕️", direction: .outcome),
            Category(id: 12, name: "Образование", emoji: "🎓", direction: .outcome),
            Category(id: 13, name: "Развлечения", emoji: "🎮", direction: .outcome),
            Category(id: 14, name: "Путешествия", emoji: "✈️", direction: .outcome),
            Category(id: 15, name: "Питомец", emoji: "🐶", direction: .outcome),
            Category(id: 16, name: "Подарки", emoji: "🎀", direction: .outcome),
            Category(id: 17, name: "Техника", emoji: "💻", direction: .outcome),
            Category(id: 18, name: "Красота", emoji: "💄", direction: .outcome),
            Category(id: 19, name: "Связь", emoji: "📱", direction: .outcome),
            Category(id: 20, name: "Спорт", emoji: "🏋️", direction: .outcome),
            Category(id: 21, name: "Книги", emoji: "📚", direction: .outcome),
            Category(id: 22, name: "Ремонт", emoji: "🔨", direction: .outcome),
            Category(id: 23, name: "Налоги", emoji: "📝", direction: .outcome),
            Category(id: 24, name: "Страхование", emoji: "🛡️", direction: .outcome),
            Category(id: 25, name: "Долги", emoji: "🏦", direction: .outcome),
            Category(id: 26, name: "Хобби", emoji: "🎨", direction: .outcome),
            Category(id: 27, name: "Дети", emoji: "👶", direction: .outcome),
            Category(id: 28, name: "Благотворительность", emoji: "❤️", direction: .outcome),
            Category(id: 29, name: "Канцелярия", emoji: "📎", direction: .outcome),
            Category(id: 30, name: "Подписки", emoji: "🔁", direction: .outcome)
        ]
        _categories = categoryCreation
    }
    
    func getAll() async -> [Category] {
        return _categories
    }
    
    func getByDirection(_ direction: Direction) async -> [Category] {
        return _categories.filter({ $0.direction == direction })
    }
}

