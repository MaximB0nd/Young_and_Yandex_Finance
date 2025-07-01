//
//  ApplicationFlow.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 18.06.2025.
//

import SwiftUI

struct ApplicationFlow: View {
    var body: some View {
        MainFlow()
            .onAppear {
                UIBarButtonItem.appearance().tintColor = .people
            }
    }
}

#Preview {
    ApplicationFlow()
}
