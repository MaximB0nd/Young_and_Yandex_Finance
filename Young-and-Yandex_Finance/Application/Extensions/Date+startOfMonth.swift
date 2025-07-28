//
//  Date+startOfMonth.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 26.07.2025.
//

import Foundation

extension Date {
    func startOfMonth() -> Date {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month], from: self)
        return calendar.date(from: components)!
    }
}
