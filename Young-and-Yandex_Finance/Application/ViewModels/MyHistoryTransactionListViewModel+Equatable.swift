//
//  MyHistoryTransactionListViewModel+Equatable.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 01.07.2025.
//

import Foundation

extension MyHistoryTransactionListViewModel: Equatable {
    static func == (lhs: MyHistoryTransactionListViewModel, rhs: MyHistoryTransactionListViewModel) -> Bool {
        lhs.dateFrom == rhs.dateFrom &&
        lhs.dateTo == rhs.dateTo &&
        lhs.sortSelection == rhs.sortSelection &&
        lhs.transactions == rhs.transactions &&
        lhs.sum == rhs.sum &&
        lhs.currencySymbol == rhs.currencySymbol
    }
}
