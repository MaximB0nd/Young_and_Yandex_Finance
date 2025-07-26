//
//  BackBalanceHistoryChart.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 26.07.2025.
//

import SwiftUI
import Charts

struct BackBalanceHistoryChart: View {
    
    @Binding var data: [LineBakanceChartData]
    
    var body: some View {
        Chart(data, id: \.date) { item in
            BarMark(
                x: .value("Date", item.date),
                y: .value("Balance", abs(item.balance))
            )
            .foregroundStyle(item.balance >= 0 ? .green : .red)
        }
        .chartYAxis(.hidden)
        .chartXAxis {
            AxisMarks(values: .stride(by: .day, count: 14)) { value in
                if let date = value.as(Date.self) {
                    AxisValueLabel {
                        Text(date, format: .dateTime.day().month(.twoDigits))
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 250)
    }
}
