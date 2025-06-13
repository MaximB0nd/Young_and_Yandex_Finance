//
//  Young_and_Yandex_FinanceTests.swift
//  Young-and-Yandex_FinanceTests
//
//  Created by Максим Бондарев on 12.06.2025.
//

import Testing
import Foundation

@testable import Young_and_Yandex_Finance

struct APIParsingTests {
    
    let token = ""    //  <-  your token

    @Test func testAPIGet() throws {
        if token == "" {
            Issue.record("Не указан токен")
            return
        }
        
        guard let url = URL(string: "https://shmr-finance.ru/api/v1/transactions/1")  else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                let json = try JSONSerialization.jsonObject(with: data!)
                let transaction = Transaction.parce(jsonObject: json)
                #expect(transaction != nil)
            } catch {
                print("Ошибка парсинга")
            }
        }
        task.resume()
        var a = true
        while a { Thread.sleep(forTimeInterval: 5); a = false}
    }
}
