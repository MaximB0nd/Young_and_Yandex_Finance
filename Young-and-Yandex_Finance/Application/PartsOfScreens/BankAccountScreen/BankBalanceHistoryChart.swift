//
//  BackBalanceHistoryChart.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 26.07.2025.
//

import SwiftUI
import Charts

struct BankBalanceHistoryChart: View {
    
    @Binding var data: [LineBakanceChartData]
    
    var body: some View {
        Chart(data, id: \.date) { item in
            BarMark(
                x: .value("Date", item.date, unit: data.count == 24 ? .month : .day),
                y: .value("Balance", abs(item.balance == 0 ? 1 : item.balance))
            )
            .foregroundStyle(item.balance == 0 ? .gray : item.balance > 0 ? .green : .red)
        }
        .chartYAxis(.hidden)
        .chartXAxis {
            AxisMarks(values: .stride(by: .day, count: data.count == 24 ? 300 : 13)) { value in
                if let date = value.as(Date.self) {
                    AxisValueLabel {
                        Text(date, format: data.count == 24 ? .dateTime.day().month(.twoDigits).year() : .dateTime.day().month(.twoDigits))
                    }
                }
            }
        }
    }
}
