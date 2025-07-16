//
//  NetworkClient+BaseRequest.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 16.07.2025.
//

import Foundation

extension NetworkClient {
    func post(_ request: URLRequest) async throws -> Data {
        
        guard let token = token else { throw Errors.invalidToken }
        
        var request = request
        
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "accept")
        request.httpMethod = "POST"
        
        let (responseData, response) = try await session.data(for: request)
        guard response.value(forKey: "statusCode") as? Int == 201 else {
            throw Errors.serverError(code: response.value(forKey: "statusCode") as! Int)
        }
        
        return responseData
    }
}
