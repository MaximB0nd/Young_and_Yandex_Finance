//
//  ApplicationFlow.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 18.06.2025.
//

import SwiftUI

struct ApplicationFlow: View {

    @State var errorProvider = ErrorLabelProvider.shared
    
    var body: some View {
        MainFlow()
            .onAppear {
                UIBarButtonItem.appearance().tintColor = .people
            }
            .alert("Ошибка загрузки", isPresented: $errorProvider.isErrorLabelVisible, actions: {}, message: { Text(errorProvider.errorLabelText ?? "") })
    }
}

#Preview {
    ApplicationFlow()
}
