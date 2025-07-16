//
//  NetworkClient+CategoryRequests.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 16.07.2025.
//

import Foundation

extension NetworkClient {
    class category {
        // get all categories
        static func request() async throws -> [Category] {
            let url = baseURL.appendingPathComponent("categories")
            
            let request = URLRequest(url: url)
            
            let response = try await get(request)
            
            return try toModel(data: response)
        }
    }
}
