//
//  Transaction.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 12.06.2025.
//

import Foundation

///This model has the same values as request from server
///Parced Json is the same
///But values of Accaunt and Categoty without their id have none values
///because these values are not neaded, we will get all information of it by self id to have updated values///

struct Transaction {
    let id: Int
    let account: Account
    var category: Category
    var amount: Decimal
    var transactionDate: Date
    var comment: String?
    let createdAt: Date
    var updatedAt: Date
}
