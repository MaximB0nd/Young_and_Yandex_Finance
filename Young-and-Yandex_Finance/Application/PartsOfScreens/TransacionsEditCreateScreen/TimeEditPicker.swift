//
//  TimeEditPicker.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 11.07.2025.
//

import SwiftUI

struct TimeEditPicker: View {
    @Binding var time: Date
    
    var body: some View {
        HStack {
            Text("Дата")
            Spacer()
            DatePicker(selection: $time, in: ...Date(), displayedComponents: .hourAndMinute) {}
                .background(Color("LightAccent").clipShape(.buttonBorder))
        }
    }
}
