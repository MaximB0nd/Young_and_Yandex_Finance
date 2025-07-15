//
//  AnalyticsScreen.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 12.07.2025.
//

import SwiftUI

struct AnalyticsScreenUIKit: UIViewControllerRepresentable {
    @Binding var selectedTransaction: Transaction?
    let direction: Direction
    func makeUIViewController(context: Context) -> AnaliticsViewController {
        return AnaliticsViewController(direction: direction, transaction: $selectedTransaction)
    }
    func updateUIViewController(_ uiViewController: AnaliticsViewController, context: Context) {}
}
