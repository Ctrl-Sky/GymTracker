//
//  CalendarCell.swift
//  Gym1.1
//
//  Created by Sky Quan on 2023-12-28.
//

import SwiftUI

struct CalendarCell: View {
    @EnvironmentObject var dateHolder: DateHolder
    let count: Int
    let startingSpaces: Int
    let daysInMonth: Int
    let daysInPrevMonth: Int
    var accessedDates: [Int]
    var statsView: Bool
    
    var body: some View {
        ZStack{
            Circle()
                .frame(width: 30)
                .foregroundStyle(foregroundColor(statsView: statsView, type: monthStruct().monthType, day: monthStruct().dayInt, accessedDates: accessedDates))
        
            Text(monthStruct().day())
                .foregroundStyle(textColour(type: monthStruct().monthType))
                .frame(maxWidth: .infinity, maxHeight: .infinity) // MARK: CHANGE FRAME HERE
        }
    }
    
    func foregroundColor(statsView: Bool, type: MonthType, day: Int, accessedDates: [Int]) -> Color{
        let color1 = statsView ? Color("Custom6") : Color("Custom2")
        let color2 = statsView ? Color("Custom1") : .white
        var usedColor: Color = color2
        if type == MonthType.Current{
            if accessedDates.contains(day){
                usedColor = color1
            }
        }
        return usedColor
    }

    func textColour(type: MonthType) -> Color{
        return type == MonthType.Current ? Color.black : Color.gray
    }
    
    func monthStruct() -> MonthStruct{
        let start = startingSpaces == 0 ? startingSpaces + 7 : startingSpaces
        if count <= start{
            let day = daysInPrevMonth + count - start
            return MonthStruct(monthType: MonthType.Previous, dayInt: day)
        }
        else if count - start > daysInMonth{
            let day = count - start - daysInMonth
            return MonthStruct(monthType: MonthType.Next, dayInt: day)
        }
        let day = count - start
        return MonthStruct(monthType: MonthType.Current, dayInt: day)
    }
}

#Preview {
    CalendarCell(count: 5, startingSpaces: 3, daysInMonth: 5, daysInPrevMonth: 1, accessedDates: [2], statsView: false)
}
