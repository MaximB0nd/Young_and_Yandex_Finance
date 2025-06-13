//
//  JsonTests.swift
//  Young-and-Yandex_FinanceTests
//
//  Created by Максим Бондарев on 12.06.2025.
//

import Testing
import Foundation


struct JsonTests {
    
//    @Test func testFileParce() {
//        let fileURL = Bundle.main.url(forResource: "Test1", withExtension: "json")!
//        try! FileManager.default.attributesOfItem(atPath: fileURL.path)
//        
//        let data = try! Data(contentsOf: fileURL)
//        let jsonObj = try! JSONSerialization.jsonObject(with: data)
//        let transaction = Transaction.parce(jsonObject: jsonObj)
//    }
    
    @Test func testTransactionToJson() {
        var transaction: Transaction? = .init(id: 1, account: .init(id: 1, name: "Name account", balance: 100, currency: "RUB"), category: .init(id: 1, name: "Name category", emoji: "😀", direction: .income), amount: 123, transactionDate: .now, createdAt: .now, updatedAt: .now)
        
        let jsonData = transaction!.jsonObject
        transaction = Transaction.parce(jsonObject: jsonData)
        #expect(transaction != nil)
    }

}
