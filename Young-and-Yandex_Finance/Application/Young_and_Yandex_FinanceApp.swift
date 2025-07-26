//
//  Young_and_Yandex_FinanceApp.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 12.06.2025.
//

import SwiftUI
import SwiftData
import LottieStartWindow

@main
struct Young_and_Yandex_FinanceApp: App {
    
    @State var finishedLoading: Bool = false
    
    var body: some Scene {
        WindowGroup {
            if finishedLoading {
                ApplicationFlow()
                    .transition(.opacity)
            } else {
                AnimatedIcon(name: "AnimatedPig", isFinished: $finishedLoading)
                    .transition(.opacity)
            }
        }
    }
}
