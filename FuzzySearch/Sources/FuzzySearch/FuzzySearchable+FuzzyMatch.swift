//
//  File.swift
//  FuzzySearch
//
//  Created by Максим Бондарев on 03.07.2025.
//

import Foundation

public extension FuzzySearchable {
    func fuzzyMatch(query: String, characters: FuzzySearchString) -> FuzzySearchMatchResult {
        let compareString = characters.characters // the string we compare against
        let searchString = query.lowercased() // make the query case-insensitive

        var totalScore = 0 // represents the weight of the match
        var matchedParts = [NSRange]() // Ranges that match compareString and searchString

        // This is always the data for one match
        var patternIndex = 0
        var currentScore = 0
        var currentMatchedPart = NSRange(location: 0, length: 0)

        for (index, character) in compareString.enumerated() {
            if let prefixLength = searchString.hasPrefix(prefix: character, startingAt: patternIndex) {
                // A match was found, so we increment the score and the range
                patternIndex += prefixLength
                currentScore += 1
                currentMatchedPart.length += 1
            } else {
                // No match was found
                currentScore = 0
                if currentMatchedPart.length != 0 {
                    matchedParts.append(currentMatchedPart)
                }
                currentMatchedPart = NSRange(location: index + 1, length: 0)
            }
            totalScore += currentScore
        }

        if currentMatchedPart.length != 0 {
            matchedParts.append(currentMatchedPart)
        }

        if searchString.count == matchedParts.reduce(0, { partialResults, range in
            range.length + partialResults
        }) {
            return FuzzySearchMatchResult(weight: totalScore, matchedParts: matchedParts)
        } else {
            return FuzzySearchMatchResult(weight: 0, matchedParts: [])
        }
    }
    
    func normaliseString() -> FuzzySearchString {
        return FuzzySearchString(characters: searchableString.normalise())
    }
}
