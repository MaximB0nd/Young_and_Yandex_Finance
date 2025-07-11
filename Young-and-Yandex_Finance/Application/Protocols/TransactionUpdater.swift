//
//  TransactionUpdated.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 11.07.2025.
//

import Foundation

protocol TransactionUpdater {
    
    func doneTransaction() async throws
    
    var category: Category? { get set }
    var amount: Decimal? { get set }
    var transactionDate: Date { get set }
    var comment: String? { get set }
}
