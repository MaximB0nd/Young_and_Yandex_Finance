//
//  NetworkClient.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 15.07.2025.
//

import Foundation

final class NetworkClient {
    let baseURL = URL(string: "https://shmr-finance.ru/api/v1/")!
    internal let session: URLSession = .shared
    
    // To start work you have to create a text filen with title "Codes.txt"
    // You should write in it your own token
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
    
    // server creating new account
    func request(newAccount: BankAccountForRequest) async throws -> BankAccount {
        let url = baseURL.appendingPathComponent("accounts")
        let data = try toData(model: newAccount)
        
        var request = URLRequest(url: url)
        request.httpBody = data
        
        let response = try await post(request)
        
        return try toModel(data: response)
    }
    
    func postNewAccount() async throws {
        let url = baseURL.appendingPathComponent("")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        try await session.data(for: request)
    }
    
                               
    
}
