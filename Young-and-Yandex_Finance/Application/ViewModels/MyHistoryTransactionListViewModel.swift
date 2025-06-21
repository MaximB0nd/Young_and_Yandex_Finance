//
//  MyHistoryTransactionListViewModel.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 21.06.2025.
//

import Foundation

final class MyHistoryTransactionListViewModel {
    private(set) var transactions: [Transaction] = []
    private(set) var sum: Decimal = 0
    private(set) var currencySymbol: String = ""
    private var direction: Direction
    
    var transactionService: TransactionsService
    
    init(transactionService: TransactionsService, direction: Direction) {
        self.transactionService = transactionService
        self.direction = direction
    }
    
    func getTransactions(from date1: Date, to date2: Date, by direction: Direction) async {
        self.transactions = await transactionService.getTransactions(from: date1, to: date2).filter({$0.category.direction == direction})
    }
    
    func getSum() async {
        sum = transactions.reduce(0) { $0 + $1.amount }
    }
    
    func getCurrencySymbol() async {
        currencySymbol = transactions.count > 0 ? transactions[0].account.currencySymbol : ""
    }
    
    func updateData(from date1: Date, to date2: Date) async {
        await getTransactions(from: date1, to: date2, by: direction)
        await getSum()
        await getCurrencySymbol()
    }
}
