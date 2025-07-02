//
//  File.swift
//  FuzzySearch
//
//  Created by Максим Бондарев on 03.07.2025.
//

import Foundation

public protocol FuzzySearchable {
    var searchableString: String { get }

    func fuzzyMatch(query: String, characters: FuzzySearchString) -> FuzzySearchMatchResult
}
