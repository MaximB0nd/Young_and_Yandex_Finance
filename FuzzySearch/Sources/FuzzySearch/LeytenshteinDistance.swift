//
//  File.swift
//  FuzzySearch
//
//  Created by Максим Бондарев on 09.07.2025.
//

import Foundation

extension FuzzySearchable {
    
    func LeytenshteinDistancePerLen(to t: String) -> Double {
        let sLength = searchableName.count
        let tLength = t.count
        
        var array = Array(repeating: Array(repeating: 0, count: tLength + 1), count: sLength + 1)
        
        for i in 0..<sLength + 1 {
            array[i][0] = i
        }
        
        for j in 0..<tLength + 1 {
            array[0][j] = j
        }
        
        for i in 1..<sLength + 1 {
            for j in 1..<tLength + 1 {
                array[i][j] = min(array[i - 1][j] + 1, array[i][j - 1] + 1, array[i - 1][j - 1] + 1)
            }
        }
        
        return Double(array[sLength][tLength]) / Double(sLength)
    }
}
