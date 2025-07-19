//
//  NetworkClient.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 15.07.2025.
//

import Foundation

final class NetworkClient {
    internal static let baseURL = URL(string: "https://shmr-finance.ru/api/v1/")!
    internal static let session: URLSession = .shared
    
    let account = AccountNetworkClient.self
    let category = CategoryNetworkClient.self
    let transaction = TransactionNetworkClient.self
    
    // To start work you have to create a text filen with title "Codes.txt"
    // You should write in it your own token
    internal static var token: String? {
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
}
