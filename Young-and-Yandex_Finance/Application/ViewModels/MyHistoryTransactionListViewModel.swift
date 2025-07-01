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
    
    var transactionService = TransactionsService.shared
    
    init(direction: Direction) {
        self.direction = direction
    }

    func sortByDate(_ transactions: [Transaction]) -> [Transaction] {
        return transactions.sorted { $0.transactionDate > $1.transactionDate }
    }
    
    func sortByAmount(_ transactions: [Transaction]) -> [Transaction] {
        return transactions.sorted { $0.amount > $1.amount }
    }
    
    func getTransactions(from date1: Date, to date2: Date, by direction: Direction, sortBy: SortSelectionType?) async {
        var transactions = await transactionService.getTransactions(from: date1, to: date2).filter({$0.category.direction == direction})
        if let sortBy = sortBy {
            switch sortBy {
            case .price:
                transactions = sortByAmount(transactions)
            case .date:
                transactions = sortByDate(transactions)
            case .none:
                break
            }
        }
        self.transactions = transactions
    }
    
    func getSum() async {
        sum = transactions.reduce(0) { $0 + $1.amount }
    }
    
    func getCurrencySymbol() async {
        currencySymbol = transactions.count > 0 ? transactions[0].account.currencySymbol : ""
    }
    
    func updateData(from date1: Date, to date2: Date, sort by: SortSelectionType?) async {
        await getTransactions(from: date1, to: date2, by: direction, sortBy: by)
        await getSum()
        await getCurrencySymbol()
    }
    
    func presaveDate(date1: inout Date, date2: inout Date, closure: ((Date, Date) -> Bool)) {
        DateConverter.checkDate(date1: &date1, date2: &date2, closure: closure)
    }
}
