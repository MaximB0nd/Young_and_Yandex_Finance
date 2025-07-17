//
//  NetworkClient+TransactionNetworkClient.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 16.07.2025.
//

import Foundation

extension NetworkClient {
    class TransactionNetworkClient {
        /// Create new transaction
        static func request(newTransaction: TransactionForRequest) async throws -> Transaction {
            let url = baseURL.appendingPathComponent("transactions")
            
            let data = try await toData(model: newTransaction)
            
            var request = URLRequest(url: url)
            request.httpBody = data
            
            let responce = try await post(request)
            
            let responseModel: TransactionForResponse = try await toModel(data: responce)
            var model = Transaction(from: responseModel)
            
            let account = try await AccountNetworkClient.request()
            model.account = .init(bankAccount: account.first!)
            
            let categories = try await CategoryNetworkClient.request()
            model.category = categories.first(where: {$0.id == responseModel.categoryId})!
            
            return model
        }
        
        /// Get Transaction by id
        static func request(by id: Int) async throws -> Transaction {
            let url = baseURL.appendingPathComponent("transactions/\(id)")
            
            let request = URLRequest(url: url)
            
            let responce = try await get(request)
            
            return try await toModel(data: responce)
        }
        
        /// Update transaction by id
        static func request(newTransaction: TransactionForRequest, by id: Int) async throws -> Transaction {
            let url = baseURL.appendingPathComponent("transactions/\(id)")
            
            var request = URLRequest(url: url)
            request.httpBody = try await toData(model: newTransaction)
            
            let responce = try await put(request)
            
            return try await toModel(data: responce)
        }
        
        /// Delete transaction by id
        static func request(by id: Int) async throws {
            let url = baseURL.appendingPathComponent("transactions/\(id)")
            
            let request = URLRequest(url: url)
            
            try await delete(request)
        }
        
        /// Get all transactions
        static func request(by id: Int) async throws -> [Transaction] {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            
            var url = baseURL.appendingPathComponent("transactions/account/\(id)/period")
            
            url = url.appending(queryItems: [URLQueryItem(name: "startDate", value: "0001-01-01"), URLQueryItem(name: "endDate", value: formatter.string(from: .now.addingTimeInterval(60 * 60)))])
            
            let request = URLRequest(url: url)
            
            let responce = try await get(request)
            
            return try await toModel(data: responce)
        }
        
        /// Get transactions by dateFROM to dateTO
        static func request(by id: Int, from dateFrom: Date, to dateTo: Date) async throws -> [Transaction] {
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd"
            formatter.timeZone = TimeZone(secondsFromGMT: 0)
            
            var url = baseURL.appendingPathComponent("transactions/account/\(id)/period")
            
            url = url.appending(queryItems: [
                URLQueryItem(name: "startDate", value: formatter.string(from: dateFrom)),
                URLQueryItem(name: "endDate", value: formatter.string(from: dateTo))
            ])
            
            let request = URLRequest(url: url)
            
            let responce = try await get(request)
            
            return try await toModel(data: responce)
        }
    }
}
