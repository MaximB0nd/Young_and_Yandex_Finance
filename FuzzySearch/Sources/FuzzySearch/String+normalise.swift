//
//  File.swift
//  FuzzySearch
//
//  Created by Максим Бондарев on 03.07.2025.
//

import Foundation

public extension String {
    func normalise() -> [FuzzySearchCharacter] {
        return self.lowercased().map { char in
        guard let data = String(char).data(using: .ascii, allowLossyConversion: true), let normalisedCharacter = String(data: data, encoding: .ascii) else {
            return FuzzySearchCharacter(content: String(char), normalisedContent: String(char))
            }

        return FuzzySearchCharacter(content: String(char), normalisedContent: normalisedCharacter)
        }
    }
}
