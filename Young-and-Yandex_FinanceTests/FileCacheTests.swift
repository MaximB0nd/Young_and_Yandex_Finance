//
//  FileCacheTests.swift
//  Young-and-Yandex_FinanceTests
//
//  Created by Максим Бондарев on 13.06.2025.
//

import Testing
import Foundation

struct FileCacheTests {

    @Test func fileChackSave() async throws {
        let cache = TransactionsFileCache()
        let transaction1: Transaction =
            .init(id: 1,
                  account: .init(id: 1, name: "wqeqwe", balance: Decimal(1000), currency: "USD"),
                  category: .init(id: 1, name: "Ремонт квартиры", emoji: "🔨", direction: .income),
                  amount: 100.0,
                  transactionDate: .now,
                  comment: nil,
                  createdAt: .now,
                  updatedAt: .now)
        let transaction2: Transaction =
            .init(id: 2,
                  account: .init(id: 1, name: "name", balance: Decimal(1000), currency: "USD"),
                  category: .init(id: 1, name: "На собачку", emoji: "🐕", direction: .income),
                  amount: 100.0,
                  transactionDate: .now,
                  comment: "Энни",
                  createdAt: .now,
                  updatedAt: .now)
        cache.add(transaction1)
        cache.add(transaction2)
        #expect(cache.transactions.count == 2)
        
         try! cache.save(fileName: "Y&Y_Finance-transactions.json")
    }
    
    @Test func fileChackLoad() async throws {
        let cache = TransactionsFileCache()
        try! cache.load(paths: "Y&Y_Finance-transactions.json")
        #expect(cache.transactions.count == 2)
    }
}
