//
//  TransactionListViewModelProtocol.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 20.06.2025.
//

import Foundation

protocol TransactionListViewModelProtocol {
    var transactions: [Transaction] { get }
    var sum: Decimal { get }
    var currencySymbol: String { get }

    func getTransactions(by direction: Direction) async
    
    func getSum() async
    
    func getCurrencySymbol() async 
}
