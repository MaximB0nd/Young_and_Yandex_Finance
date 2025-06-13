//
//  JsonTests.swift
//  Young-and-Yandex_FinanceTests
//
//  Created by Максим Бондарев on 12.06.2025.
//

import Testing
import Foundation


struct JsonTests {
    
    @Test func testFileParce() {
        let fileURL = Bundle.main.url(forResource: "Test2", withExtension: "json")!
        try! FileManager.default.attributesOfItem(atPath: fileURL.path)
        
        let data = try! Data(contentsOf: fileURL)
        let jsonObject = try! JSONSerialization.jsonObject(with: data, options: [])
        let transaction = Transaction.parce(jsonObject: jsonObject)
        
        print(transaction)
        
        #expect(transaction != nil)
        
        print(transaction?.jsonObject)
        
        print(Transaction.parce(jsonObject: transaction?.jsonObject))
    }
}
