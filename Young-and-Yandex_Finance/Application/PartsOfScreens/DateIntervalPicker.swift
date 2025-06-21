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
        List {
            
            dateFromPicker
                
            dateToPicker
        }
        .onChange(of: dateFrom) {
            DateConverter.checkDate(date1: &dateFrom, date2: &dateTo, closure: {$0 < $1})
            dateFrom = DateConverter.startOfDay(date: dateFrom)
            print(dateFrom)
        }
        .onChange(of: dateTo) {
            DateConverter.checkDate(date1: &dateTo, date2: &dateFrom, closure: {$0 > $1})
            dateTo = DateConverter.endOfDay(date: dateTo)
            print(dateTo)
        }
    }
    
    var dateFromPicker: some View {
        HStack {
            Text("Начало")
            Spacer()
            DatePicker(selection: $dateFrom, displayedComponents: .date) {}
                .tint(.black)
                .background(Color("DatePicker").clipShape(.buttonBorder))
        }
        .environment(\.colorScheme, .light)
    }
    
    var dateToPicker: some View {
        HStack {
            Text("Конец")
            Spacer()
            DatePicker(selection: $dateTo, displayedComponents: .date) {}
                .foregroundStyle(.black)
                .background(Color("DatePicker").clipShape(.buttonBorder))
        }
        .environment(\.colorScheme, .light)
    }
}
