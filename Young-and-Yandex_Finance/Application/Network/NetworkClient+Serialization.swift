//
//  +JSONSerialisation.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 15.07.2025.
//

import Foundation

extension NetworkClient {

    internal static func toData(model: some Encodable) async throws -> Data {
        try JSONSerialization.data(withJSONObject:  try JSONSerialization.jsonObject(with: try JSONEncoder().encode(model))
        )
    }
    
    internal static func toModel<T: Decodable>(data: Data) async throws -> T {
        try JSONDecoder().decode(T.self, from: data)
    }
        
    
}

