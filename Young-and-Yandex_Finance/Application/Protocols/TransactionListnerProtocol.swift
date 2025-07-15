//
//  TransactionListner.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 10.07.2025.
//

import Foundation

protocol TransactionListnerProtocol: AnyObject {
    func updateTransactions() async
}
