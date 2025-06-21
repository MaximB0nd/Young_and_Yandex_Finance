//
//  MyHistoryScreen.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 21.06.2025.
//

import SwiftUI

struct MyHistoryScreen: View {
    
    let direction: Direction
    
    @State var dateFrom: Date = DateConverter.previousMonth(date: Date.now)

    @State var dateTo: Date = DateConverter.endOfDay(date: Date.now)
    
    var body: some View {
        DateIntervalPicker(dateFrom: $dateFrom, dateTo: $dateTo)
    }
}

#Preview {
    MyHistoryScreen(direction: .outcome)
}
