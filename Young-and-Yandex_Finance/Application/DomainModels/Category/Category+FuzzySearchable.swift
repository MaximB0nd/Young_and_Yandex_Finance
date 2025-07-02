//
//  Category+fuzzyResearchable.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 03.07.2025.
//

import Foundation
import FuzzySearch

extension Category: FuzzySearchable  {
    var searchableString: String {
        name
    }
}
