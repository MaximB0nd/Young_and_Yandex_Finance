//
//  +JSONSerialisation.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 15.07.2025.
//

import Foundation

extension NetworkClient {
    
    func toData(model: some Encodable) throws -> Data {
        try JSONSerialization.data(withJSONObject:  try JSONSerialization.jsonObject(with: try JSONEncoder().encode(model))
        )
    }
    
    func toModel<T: Decodable>(data: Data) throws -> T {
        try JSONDecoder().decode(T.self, from: data)
    }
}

