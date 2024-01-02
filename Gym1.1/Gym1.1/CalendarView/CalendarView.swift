//
//  CalendarView.swift
//  Gym1.1
//
//  Created by Sky Quan on 2023-12-28.
//

import SwiftUI

struct CalendarView: View {
    
    @EnvironmentObject var dateHolder: DateHolder
    var dates: [Date]
    var statsView: Bool = false
    
    var body: some View {
        VStack(spacing: 1){
            DateScrollerView()
                .environmentObject(dateHolder)
                .padding()
            dayOfWeekStack
            calendarGrid
        }
    }
    
    var dayOfWeekStack: some View{
        HStack(spacing: 1){
            Text("Sun").dayOfWeek()
            Text("Mon").dayOfWeek()
            Text("Tues").dayOfWeek()
            Text("Wed").dayOfWeek()
            Text("Thurs").dayOfWeek()
            Text("Fri").dayOfWeek()
            Text("Sat").dayOfWeek()
        }
    }
    
    var calendarGrid: some View{
        VStack(spacing: 1){
            let daysInMonth = CalendarHelper().daysInMonth(dateHolder.date)
            let firstDayMonth = CalendarHelper().firstOfMonth(dateHolder.date)
            let startingSpaces = CalendarHelper().weekday(firstDayMonth)
            let prevMonth = CalendarHelper().minusMonth(dateHolder.date)
            let daysInPrevMonth = CalendarHelper().daysInMonth(prevMonth)
            let accessedDates = CalendarHelper().extractAccessedDates(current: DateHolder().date, dates: dates)
            
            ForEach(0..<6){ row in
                HStack(spacing: 1){
                    ForEach(1..<8){ column in
                        let count = column + (row * 7)
                        CalendarCell(count: count, startingSpaces: startingSpaces, daysInMonth: daysInMonth, daysInPrevMonth: daysInPrevMonth, accessedDates: accessedDates, statsView: statsView)
                            .environmentObject(dateHolder)
                    }
                }
            }
        }
    }
}

//#Preview {
//    let dateHolder = DateHolder()
//    CalendarView()
//        .environmentObject(dateHolder)
//}

extension Text{
    func dayOfWeek() -> some View{
        self.frame(maxWidth: .infinity) // MARK: COME HERE TO CHANGE FRAM
            .padding(.top, 1)
            .lineLimit(1)
    }
}
