//
//  APIRequestsTests.swift
//  Young-and-Yandex_FinanceTests
//
//  Created by Максим Бондарев on 16.07.2025.
//

import Testing

struct APIRequestsTests {

    var client = NetworkClient()
    
//    @Test func requestNewAccountTest() async throws {
//        let newAccount = NetworkClient.BankAccountForRequest(name: "MaxBond", balance: 1000.0, currency: "RUB")
//        let account = try await client.request(newAccount: newAccount)
//        print(account)
//        #expect(account.name == "MaxBond")
//    }
    
    @Test func requestAccountByIdTest() async throws {
        let account: [BankAccount] = try await client.account.request()
        #expect(account.count != 0)
    }
    
    @Test func requestUpdateAccountTest() async throws {
        let newAccount = NetworkClient.BankAccountForRequest(name: "Max Bond", balance: 2000.0, currency: "RUB")
        
        let updatedAccount = try await client.account.request(by: 77, newAccount: newAccount)
        print(updatedAccount)
        #expect(newAccount.name == updatedAccount.name)
    }
    
//    @Test func deleteAccountTest() async throws {
//        try await client.account.request(by: 347)
//    }
}
