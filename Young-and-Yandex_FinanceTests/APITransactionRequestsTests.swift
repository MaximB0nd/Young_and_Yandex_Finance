//
//  APITransactionRequestsTests.swift
//  Young-and-Yandex_FinanceTests
//
//  Created by Максим Бондарев on 16.07.2025.
//

import Foundation
import Testing

struct APITransactionRequestsTests {
    
    var client = NetworkClient()
    
//    @Test func createTransactionTest() async throws {
//        let transaction = NetworkClient.TransactionForRequest(accountId: 77, categoryId: 1, amount: 500.00, transactionDate: Date(), comment: "some chtoto")
//
//        let new = try await client.transaction.request(newTransaction: transaction)
//        print(new)
//        
//        #expect(new.account.id == 77)
//    }
////    
//    @Test func getTransactionByIdTest() async throws {
//        let id = 4538
//        let transaction: Transaction = try await client.transaction.request(by: id)
//        
//        print(transaction)
//        #expect(transaction.id == 4538)
//    }
    
    @Test func getAllTransactionsTest() async throws {
        let transactions: [Transaction] = try await client.transaction.request(by: 77)
        
        #expect(transactions.count > 0)
    }
    
    @Test func getAllTransactionsByDateTest() async throws {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date1: Date = dateFormatter.date(from: "2025-07-16")!
        let date2: Date = dateFormatter.date(from: "2025-07-18")!
        let transactions: [Transaction] = try await client.transaction.request(by: 77, from: date1, to: date2)
        
        #expect(transactions.count > 0)
    }
}
