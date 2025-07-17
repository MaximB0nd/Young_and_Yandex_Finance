//
//  Errors.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 16.07.2025.
//

import Foundation

extension NetworkClient {
    enum Errors: Error {
        case invalidToken
        case serverError(code: Int)
        case unknownError
    }
}

