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
    
    var token: String? {
        guard let url =  Bundle.main.url(forResource: "Codes", withExtension: "txt") else {
            return nil
        }
        do {
            var token = try String(contentsOf: url, encoding: .utf8)
            if token.contains("\n") {
                token.remove(at: token.firstIndex(of: "\n")!)
            }
            return token
        } catch {
            return nil
        }
    }

    @Test func testAPIGet() throws {
        guard let token = self.token else {
            Issue.record("Не указан токен")
            return
        }
        
        guard let url = URL(string: "https://shmr-finance.ru/api/v1/transactions/3")  else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            do {
                let json = try JSONSerialization.jsonObject(with: data!)
                let transaction = Transaction.parse(jsonObject: json)
                guard let transaction = transaction else {
                    Issue.record( "Не удалось распарсить JSON")
                    return
                }
                
            } catch {
                print("Ошибка парсинга")
            }
        }
        task.resume()
        var a = true
        while a { Thread.sleep(forTimeInterval: 5); a = false}
    }
}
