//
//  TransactionUpdated.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 11.07.2025.
//

import Foundation

protocol TransactionUpdater {
    
    var category: Category? { get set }
    var amount: Decimal? { get set }
    var transactionDate: Date { get set }
    var comment: String { get set }
    var amountText: String { get set }
    var account: Transaction.Account? { get set }
    
    var errors: [String] { get set }
    var isError: Bool { get set }
    var getErrors: String { get }
    
    func doneTransaction() async
    func onChangeAmountText() 
    func clear() 
    func onDelete() async
}
