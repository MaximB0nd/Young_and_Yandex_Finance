//
//  JsonTests.swift
//  Young-and-Yandex_FinanceTests
//
//  Created by Максим Бондарев on 12.06.2025.
//

import Testing
import Foundation


struct JsonTests {
    
    @Test func testParce() {
        let transaction: Transaction =
            .init(id: 1,
                  account: .init(id: 1, name: "name", balance: Decimal(1000), currency: "USD"),
                  category: .init(id: 1, name: "name", emoji: "🤣", direction: .income),
                  amount: 100.0,
                  transactionDate: .now,
                  comment: nil,
                  createdAt: .now,
                  updatedAt: .now)
        let newTransaction = Transaction.parce(jsonObject: transaction.jsonObject)
        #expect(newTransaction != nil)
    }
}
