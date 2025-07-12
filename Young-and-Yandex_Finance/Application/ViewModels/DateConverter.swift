//
//  MyHistoryViewModel.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 21.06.2025.
//

import Foundation

final class DateConverter {
    static func startOfDay(_ date: Date) -> Date {
        Calendar.current.startOfDay(for: date)
    }

    static func endOfDay(_ date: Date, in calendar: Calendar = .current) -> Date {
        guard let nextDay = calendar.date(byAdding: .day, value: 1, to: date) else {
            return date
        }
        let startOfNextDay = calendar.startOfDay(for: nextDay)
        return calendar.date(byAdding: .second, value: -1, to: startOfNextDay) ?? startOfNextDay
    }
    
    static func previousMonth(date: Date) -> Date {
        let monthAgo = Calendar.current.date(byAdding: .month, value: -1, to: date) ?? date
        return Calendar.current.startOfDay(for: monthAgo)
    }
}
