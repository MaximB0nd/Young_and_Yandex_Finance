//
//  CSVTests.swift
//  Young-and-Yandex_FinanceTests
//
//  Created by Максим Бондарев on 13.06.2025.
//

import Testing
import Foundation

struct CSVTests {

    @Test func testPacreCSV() async throws {
        guard let path = Bundle.main.path(forResource: "CSV_example", ofType: "csv") else { #expect(false); return }
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let transactions = await Transaction.parce(CSV: data)
        #expect(transactions != nil)
    }
    
    @Test func testPacreNextCSV() async throws {
        guard let path = Bundle.main.path(forResource: "CSV_example2", ofType: "csv") else { #expect(false); return }
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let transactions = await Transaction.parce(CSV: data)
        #expect(transactions != nil)
    }
    
    @Test func testPacreOwnSeperetorCSV() async throws {
        guard let path = Bundle.main.path(forResource: "CSV_example1", ofType: "csv") else { #expect(false); return }
        let data = try Data(contentsOf: URL(fileURLWithPath: path))
        let transactions = await Transaction.parce(CSV: data, separator: ",", newline: "\n")
        #expect(transactions != nil)
    }

}
