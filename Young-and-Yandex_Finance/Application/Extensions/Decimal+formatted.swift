//
//  Decimal+formatted.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 22.06.2025.
//

import Foundation

extension Decimal {
    func formatted() -> String {
            let number = NSDecimalNumber(decimal: self)
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            formatter.decimalSeparator = "."
            return formatter.string(from: number) ?? "\(self)"
    }
}

