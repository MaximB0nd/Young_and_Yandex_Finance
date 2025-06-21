//
//  MyHistoryViewModel.swift
//  Young-and-Yandex_Finance
//
//  Created by Максим Бондарев on 21.06.2025.
//

import Foundation

final class DateConverter {
    static func startOfDay(date: Date) -> Date {
        return Calendar.current.startOfDay(for: date)
    }
    
    static func endOfDay(date: Date) -> Date {
        let startDate = startOfDay(date: date)
        let startOfNextDay = Calendar.current.date(byAdding: .day, value: 1, to: startDate) ?? date
        return Calendar.current.date(byAdding: .minute, value: -1, to: startOfNextDay) ?? date
    }
    
    static func previousMonth(date: Date) -> Date {
        let monthAgo = Calendar.current.date(byAdding: .month, value: -1, to: date) ?? date
        return Calendar.current.startOfDay(for: monthAgo)
    }
    
    static func checkDate(date1 d1: inout Date, date2 d2: inout Date, closure: (Date, Date) -> Bool) {
        if !closure(d1, d2) {
            d2 = d1
        }
    }
}
