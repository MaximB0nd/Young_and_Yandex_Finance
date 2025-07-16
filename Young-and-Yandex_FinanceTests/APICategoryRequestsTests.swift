//
//  APICategoryRequestsTests.swift
//  Young-and-Yandex_FinanceTests
//
//  Created by Максим Бондарев on 16.07.2025.
//

import Testing

struct APICategoryRequestsTests {
    
    var client = NetworkClient.self

    @Test func getAllCategories() async throws {
        let category = try await client.category.request()
        print(category)
        #expect(category.count == 24)
       
    }

}
