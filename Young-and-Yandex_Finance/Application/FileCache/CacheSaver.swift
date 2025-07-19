//
//  FileCacheSaver.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 17.07.2025.
//

import Foundation

protocol CacheSaver {
    
    static var shared: CacheSaver { get }
    
    // getter for private var _transactions
    var transactions: [Transaction] { get }
    
    // func to add a new transaction in _transactions (must have unique id)
    func add(_ transaction: Transaction)
    
    // func to delete a transaction in _transactions by id
    func delete(id: Int)
    
    // func to load all transaction from Json files by urls
    func load() throws
    
    func save() throws
    
    func rewrite(_ transactions: [Transaction]) throws 
}
