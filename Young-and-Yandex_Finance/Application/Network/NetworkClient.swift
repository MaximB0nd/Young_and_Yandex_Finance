//
//  NetworkClient.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 15.07.2025.
//

import Foundation



final class NetworkClient {
    let baseURL = URL(string: "https://shmr-finance.ru/api/v1/")!
    private let session: URLSession = .shared
    
    // server creating new account
    func request(newAccount: BankAccountForRequest) async throws -> BankAccount {
        let url = baseURL.appendingPathComponent("accounts")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        let (data, _) = try await session.data(for: request)
        let decoder = JSONDecoder()
        let accounts: [BankAccount] = try decoder.decode([BankAccount].self, from: data)
        return accounts
    }
    
    func postNewAccount() async throws {
        let url = baseURL.appendingPathComponent("")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        try await session.data(for: request)
    }
    
                               
    
}
