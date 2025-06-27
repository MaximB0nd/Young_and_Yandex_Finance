//
//  String+convertToDecimal.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 28.06.2025.
//

import Foundation

extension String {
    var convertToDecimal: String {
        let systemDecimalSeparator = Locale.current.decimalSeparator ?? "."
        let allowedDecimalSeparators = [",", "."]
        
        var hasMinus = false
        var hasDecimalSeparator = false
        var result = ""
        
        for char in self {
            let charString = String(char)
            
            if char == "-" {
                if !hasMinus && result.isEmpty {
                    result.append(char)
                    hasMinus = true
                }
            }
            else if char.isNumber {
                result.append(char)
            }

            else if allowedDecimalSeparators.contains(charString) {
                if !hasDecimalSeparator {
                    result.append(systemDecimalSeparator)
                    hasDecimalSeparator = true
                }
            }
        }
        
        if result == "-" || result == systemDecimalSeparator || result == "-" + systemDecimalSeparator || result.isEmpty {
            return "0"
        }
        
        return result
    }
}
