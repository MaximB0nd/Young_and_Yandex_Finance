//
//  NetworkClient+BaseRequest.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 16.07.2025.
//

import Foundation

extension NetworkClient {
    
    internal static func post(_ request: URLRequest) async throws -> Data {
        
        guard let token = token else { throw Errors.invalidToken }
        
        var request = request
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.httpMethod = "POST"
        
        let (responseData, response) = try await session.data(for: request)
        guard (200..<300).contains(response.value(forKey: "statusCode") as! Int) else {
            throw Errors.serverError(code: response.value(forKey: "statusCode") as! Int)
        }
        
        return responseData
    }
    
    internal static func get(_ request: URLRequest) async throws -> Data {
        guard let token = token else { throw Errors.invalidToken }
        
        var request = request
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.httpMethod = "GET"
        
        let (responseData, response) = try await session.data(for: request)
        guard (200..<300).contains(response.value(forKey: "statusCode") as! Int)  else {
            throw Errors.serverError(code: response.value(forKey: "statusCode") as! Int)
        }
        
        return responseData
    }
    
    internal static func put(_ request: URLRequest) async throws -> Data {
        guard let token = token else { throw Errors.invalidToken }
        
        var request = request
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.httpMethod = "PUT"
        
        let (responseData, response) = try await session.data(for: request)
        guard (200..<300).contains(response.value(forKey: "statusCode") as! Int)  else {
            throw Errors.serverError(code: response.value(forKey: "statusCode") as! Int)
        }
        
        return responseData
    }
    
    internal static func delete(_ request: URLRequest) async throws  {
        guard let token = token else { throw Errors.invalidToken }
        
        var request = request
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("*/*", forHTTPHeaderField: "accept")
        request.httpMethod = "DELETE"
        
        let (_, response) = try await session.data(for: request)
        guard (200..<300).contains(response.value(forKey: "statusCode") as! Int) else {
            throw Errors.serverError(code: response.value(forKey: "statusCode") as! Int)
        }
    }
}
