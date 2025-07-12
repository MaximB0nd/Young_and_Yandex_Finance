//
//  DatePicker.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 11.07.2025.
//

import Foundation
import SwiftUI

struct DateEditPicker: View {
    
    @Binding var date: Date
    
    var body: some View {
        HStack {
            Text("Дата")
            Spacer()
            DatePicker(selection: $date, in: ...Date() ,displayedComponents: .date) {}
                .background(Color("LightAccent").clipShape(.buttonBorder))
        }
    }
}
