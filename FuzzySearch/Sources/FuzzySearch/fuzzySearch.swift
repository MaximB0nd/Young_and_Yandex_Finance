//
//  File.swift
//  FuzzySearch
//
//  Created by Максим Бондарев on 09.07.2025.
//

import Foundation

extension Array where Element: FuzzySearchable {
    func fuzzySearch(input: Element, maxWeightDistance: Double = 0.5) -> [Element] {
        
        guard !input.searchableName.isEmpty else { return [] }
        
        var distances: [(Element, Double)] = []
        
        for i in 0..<self.count {
            let distance = input.LeytenshteinDistancePerLen(to: self[i].searchableName)
            distances.append((self[i], distance))
        }
        
        distances.sort { $0.1 < $1.1 }
        return distances.filter { $0.1 <= maxWeightDistance } .map { $0.0 }
    }
}

