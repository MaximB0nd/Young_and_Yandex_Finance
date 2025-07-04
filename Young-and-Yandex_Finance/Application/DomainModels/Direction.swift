//
//  Direction.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 12.06.2025.
//

import Foundation

enum Direction: String, Codable, CaseIterable, Identifiable {
    case income = "Доходы"
    case outcome = "Расходы"
    var id: Self { self }
}
