//
//  MyHistoryTransactionListViewModel.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 21.06.2025.
//

import Foundation

@Observable
final class MyHistoryTransactionListViewModel: TransactionListnerProtocol {

    var dateFrom: Date = DateConverter.previousMonth(date: .now)
    var dateTo: Date = DateConverter.endOfDay(.now)
    var sortSelection: SortSelectionType = .none
    
    private(set) var transactions: [Transaction] = []
    private(set) var sum: Decimal = 0
    private(set) var currencySymbol: String = ""
    private var direction: Direction
    
    var status: ShowStatus = .loading
    
    var transactionService = TransactionsService.shared
    
    var getStartDateFrom: Date {
        DateConverter.startOfDay(dateFrom)
    }
    
    var getEndDateTo: Date {
        DateConverter.endOfDay(dateTo)
    }
    
    init(direction: Direction) {
        self.direction = direction
        TransactionsService.subscribe(listener: self)
    }

    func sortByDate(_ transactions: [Transaction]) async -> [Transaction] {
        return transactions.sorted { $0.transactionDate > $1.transactionDate }
    }
    
    func sortByAmount(_ transactions: [Transaction]) async -> [Transaction] {
        return transactions.sorted { $0.amount > $1.amount }
    }
    
    func getTransactions(from date1: Date, to date2: Date, by direction: Direction, sortBy: SortSelectionType?) async {
        // Получаем все транзакции за период и фильтруем только по нужному direction
        let result = await transactionService.getTransactions(from: date1, to: date2)
        
        var transactions = result.success!.filter { $0.category.direction == self.direction }
        
        self.status = .loaded
        
        if let sortBy = sortBy {
            switch sortBy {
            case .price:
                transactions = await sortByAmount(transactions)
            case .date:
                transactions = await sortByDate(transactions)
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
    
    func updateTransactions() async {
        await getTransactions(from: dateFrom, to: dateTo, by: direction, sortBy: sortSelection)
        await getSum()
        await getCurrencySymbol()
    }
    
    func presaveDateTo() async {
        let dateToStart = Calendar.current.startOfDay(for: dateTo)
        let dateFromStart = Calendar.current.startOfDay(for: dateFrom)
        
        if dateToStart < dateFromStart {
            dateFrom = DateConverter.startOfDay(dateToStart)
        }
        dateTo = DateConverter.endOfDay(dateToStart)
    }
    
    func presaveDateFrom() async {
        let dateToStart = Calendar.current.startOfDay(for: dateTo)
        let dateFromStart = Calendar.current.startOfDay(for: dateFrom)
        
        if dateToStart < dateFromStart {
            dateTo = DateConverter.endOfDay(dateFromStart)
        }
        dateFrom = DateConverter.startOfDay(dateFromStart)
    }
}
