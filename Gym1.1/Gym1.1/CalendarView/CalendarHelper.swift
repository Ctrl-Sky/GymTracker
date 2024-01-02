//
//  CalendarHelper.swift
//  Gym1.1
//
//  Created by Sky Quan on 2023-12-28.
//

import Foundation
import SwiftUI

class CalendarHelper{
    let calendar = Calendar.current
    let dateFormatter = DateFormatter()
    
    func monthYearString(_ date: Date) -> String{
        dateFormatter.dateFormat = "LLL yyyy"
        return dateFormatter.string(from: date)
    }
    
    func plusMonth(_ date: Date) -> Date{
        return calendar.date(byAdding: .month, value: 1, to: date)!
    }
    
    func minusMonth(_ date: Date) -> Date{
        return calendar.date(byAdding: .month, value: -1, to: date)!
    }
    
    func daysInMonth(_ date: Date) -> Int{
        let range = calendar.range(of: .day, in: .month, for: date)!
        return range.count
    }
    
    func dayOfMonth(_ date: Date) -> Int{
        let components = calendar.dateComponents([.day], from: date)
        return components.day!
    }
    
    func firstOfMonth(_ date: Date) -> Date{
        let components = calendar.dateComponents([.year, .month], from: date)
        return calendar.date(from: components)!
    }
    
    func weekday(_ date: Date) -> Int{
        let components = calendar.dateComponents([.weekday], from: date)
        return components.weekday! - 1
    }
    
    func extractMonthAndYear(from date: Date) -> (month: Int, year: Int) {
        let components = calendar.dateComponents([.month, .year], from: date)
        
        return (components.month!, components.year!)
    }
    
    func extractAccessedDates(current: Date, dates: [Date]) -> [Int]{
        let daysInMonth = daysInMonth(current)
        var accessedDays: [Int] = []
        
        for date in dates{
            if extractMonthAndYear(from: current) == extractMonthAndYear(from: date){
                if dayOfMonth(date) <= daysInMonth{
                    accessedDays.append(dayOfMonth(date))
                }
            }
        }
        return accessedDays
    }
}
