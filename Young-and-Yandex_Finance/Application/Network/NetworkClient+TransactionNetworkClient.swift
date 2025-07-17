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
    }
}
