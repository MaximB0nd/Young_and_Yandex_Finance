//
//  NetworkClient+AccountRequests.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 16.07.2025.
//

import Foundation

extension NetworkClient {
    
    class AccountNetworkClient {
        /// Create new account
        static func request(newAccount: BankAccountForRequest) async throws -> BankAccount {
            let url = baseURL.appendingPathComponent("accounts")
            let data = try await toData(model: newAccount)
            
            var request = URLRequest(url: url)
            request.httpBody = data
            
            let response = try await post(request)
            
            return try await toModel(data: response)
        }
        
        /// Get all accounts
        static func request() async throws -> [BankAccount] {
            let url = baseURL.appendingPathComponent("accounts")
            
            let request = URLRequest(url: url)
            
            let response = try await get(request)
            
            return try await toModel(data: response)
        }
        
        /// Update account by id
        static func request(by id: Int, newAccount: BankAccountForRequest) async throws -> BankAccount {
            let url = baseURL.appendingPathComponent("accounts/\(id)")
            let data = try await toData(model: newAccount)
            
            var request = URLRequest(url: url)
            request.httpBody = data
            
            let response = try await put(request)
            
            return try await toModel(data: response)
        }
        
        /// Delete account by id
        static func request(by id: Int) async throws {
            let url = baseURL.appendingPathComponent( "accounts/\(id)")
            
            let request = URLRequest(url: url)
            
            try await delete(request)
        }
    }
    
    
    
}
