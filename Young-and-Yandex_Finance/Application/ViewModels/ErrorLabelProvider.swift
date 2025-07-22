//
//  ErrorLabelProvider.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 19.07.2025.
//

import Foundation
import SwiftUI

@Observable
final class ErrorLabelProvider {
    
    static var shared = ErrorLabelProvider()
    
    var errorLabelText: String?
    var isErrorLabelVisible: Bool = false
    
    func showErrorLabel(with text: String) {
        errorLabelText = text
        withAnimation() {
            isErrorLabelVisible = true
        }
    }
}
