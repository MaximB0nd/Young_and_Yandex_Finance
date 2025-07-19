//
//  Result.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 18.07.2025.
//

import Foundation

struct ResponceResult<Success, Failure> where Failure : Error {
    var success: Success?
    var error: Failure?
}

