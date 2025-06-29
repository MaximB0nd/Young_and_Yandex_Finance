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
        var integerDigits: [Character] = []
        var fractionalDigits: [Character] = []
        var foundDecimal = false
        
        for char in self {
            if char == "-" {
                if !hasMinus && integerDigits.isEmpty && fractionalDigits.isEmpty && !foundDecimal {
                    hasMinus = true
                }
            } else if char.isNumber {
                if foundDecimal {
                    fractionalDigits.append(char)
                } else {
                    integerDigits.append(char)
                }
            } else if allowedDecimalSeparators.contains(String(char)) {
                if !foundDecimal {
                    foundDecimal = true
                }
            }
        }
        
        if integerDigits.isEmpty && fractionalDigits.isEmpty && hasMinus {
            return "-"
        }
        
        if integerDigits.isEmpty && fractionalDigits.isEmpty {
            return ""
        }
        
        let integerPart: String
        if integerDigits.isEmpty {
            integerPart = "0"
        } else {
            var startIndex = 0
            while startIndex < integerDigits.count - 1 && integerDigits[startIndex] == "0" {
                startIndex += 1
            }
            integerPart = String(integerDigits[startIndex...])
        }
        
        var result = (hasMinus ? "-" : "") + integerPart
        if foundDecimal {
            result += systemDecimalSeparator + String(fractionalDigits)
        }
        
        return result
    }
}
