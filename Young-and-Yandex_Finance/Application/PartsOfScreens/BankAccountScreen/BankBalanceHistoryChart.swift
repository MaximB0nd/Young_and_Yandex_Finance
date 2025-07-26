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
    @State private var selectedItem: LineBakanceChartData?
    @State private var dragLocation: CGPoint?
    
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
        .chartOverlay { proxy in
            Rectangle()
                .fill(.clear)
                .contentShape(Rectangle())
                .gesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            let location = value.location
                            if let date = proxy.value(atX: location.x, as: Date.self) {
                                let closestItem = data.min(by: { abs($0.date.timeIntervalSince(date)) < abs($1.date.timeIntervalSince(date)) })
                                if let item = closestItem {
                                    selectedItem = item
                                    dragLocation = location
                                }
                            }
                        }
                        .onEnded { _ in
                            selectedItem = nil
                            dragLocation = nil
                        }
                )
        }
        .overlay {
            if let item = selectedItem, let location = dragLocation {
                VStack {
                    Text(item.balance.formatted())
                        .font(.caption)
                        .padding(6)
                        .background(.ultraThinMaterial)
                        .cornerRadius(6)
                        .offset(y: -40)
                }
                .position(x: location.x, y: 50)
            }
        }
    }
}
