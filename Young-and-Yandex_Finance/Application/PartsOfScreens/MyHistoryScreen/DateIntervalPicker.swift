//
//  DateIntervalPicker.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 21.06.2025.
//

import SwiftUI

struct DateIntervalPicker: View {
    
    @Binding var dateFrom: Date
    @Binding var dateTo: Date
    
    var body: some View {
        Group {
            dateFromPicker
            dateToPicker
        }
    }
    
    var dateFromPicker: some View {
        HStack {
            Text("Начало")
            Spacer()
            DatePicker(selection: $dateFrom, displayedComponents: .date) {}
                .background(Color("LightAccent").clipShape(.buttonBorder))
        }
        .environment(\.colorScheme, .light)
    }
    
    var dateToPicker: some View {
        HStack {
            Text("Конец")
            Spacer()
            DatePicker(selection: $dateTo, displayedComponents: .date) {}
                .background(Color("LightAccent").clipShape(.buttonBorder))
        }
        .environment(\.colorScheme, .light)
    }
}
