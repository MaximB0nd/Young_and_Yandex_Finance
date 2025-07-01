//
//  UIApplication+addShakeRecognizer.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 28.06.2025.
//

import SwiftUI

extension UIWindow {
    open override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        super.motionEnded(motion, with: event)
        NotificationCenter.default.post(name: .shakeNotification, object: event)
    }
}
