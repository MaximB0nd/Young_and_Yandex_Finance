//
//  TransactionListViewModel.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 20.06.2025.
//

import Foundation
import SwiftUI

@Observable
final class TodayTransactionListViewModel {
    
    private(set) var transactions: [Transaction] = []
    private(set) var sum: Decimal = 0
    private(set) var currencySymbol: String = ""

    var transactionService = TransactionsService.shared
    
    static var shared = TodayTransactionListViewModel()
    private init() {}

    func getTransactions(by direction: Direction) async {
        let today = DateConverter.startOfDay(.now)
        let endOfDay = DateConverter.endOfDay(.now)
        self.transactions = await transactionService.getTransactions(from: today, to: endOfDay).filter({$0.category.direction == direction})
    }
    
    func getSum() async {
        sum = transactions.reduce(0) { $0 + $1.amount }
    }
    
    func getCurrencySymbol() async {
        currencySymbol = transactions.count > 0 ? transactions[0].account.currencySymbol : ""
    }
    
    func updateData(by direction: Direction) async {
        await getTransactions(by: direction)
        await getSum()
        await getCurrencySymbol()
    }
}
    
