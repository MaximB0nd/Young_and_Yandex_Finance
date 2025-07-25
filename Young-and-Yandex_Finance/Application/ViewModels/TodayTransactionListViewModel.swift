//
//  TransactionListViewModel.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 20.06.2025.
//

import Foundation
import SwiftUI

@Observable
final class TodayTransactionListViewModel: TransactionListnerProtocol {
    
    var status: ShowStatus = .loading
    
    private(set) var transactions: [Transaction] = []
    private(set) var sum: Decimal = 0
    private(set) var currencySymbol: String = ""

    var transactionService = TransactionsService.shared
    let direction: Direction
    
    static var sharedIncome = TodayTransactionListViewModel(direction: .income)
    static var sharedOutcome = TodayTransactionListViewModel(direction: .outcome)
    private init(direction: Direction) {
        self.direction = direction
        TransactionsService.subscribe(listener: self)
    }

    func getTransactions(by direction: Direction) async {
        let today = DateConverter.startOfDay(.now)
        let endOfDay = DateConverter.endOfDay(.now)
        let transactions = await transactionService.getTransactions(from: today, to: endOfDay)
        self.transactions = transactions.filter({$0.category.direction == direction})
        
        self.status = .loaded 
        
    }
    
    func getSum() async {
        sum = transactions.reduce(0) { $0 + $1.amount }
    }
    
    func getCurrencySymbol() async {
        currencySymbol = transactions.count > 0 ? transactions[0].account.currencySymbol : ""
    }
    
    func updateTransactions() async {
        await getTransactions(by: direction)
        await getSum()
        await getCurrencySymbol()
    }
}
    
