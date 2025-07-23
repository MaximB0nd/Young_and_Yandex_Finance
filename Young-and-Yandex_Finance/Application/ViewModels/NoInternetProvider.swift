//
//  NoInternetProvider.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 22.07.2025.
//

import Foundation

@Observable
class NoInternetProvider {
    
    static var shared = NoInternetProvider()
    
    private init() {}
    
    var noInternet = false
    
    func On() {
        self.noInternet = false
    }
    
    func Off() {
        self.noInternet = true
    }
}
