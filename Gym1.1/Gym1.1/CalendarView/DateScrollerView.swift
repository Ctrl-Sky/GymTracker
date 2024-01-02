//
//  DateScrollerView.swift
//  Gym1.1
//
//  Created by Sky Quan on 2023-12-28.
//

import SwiftUI

struct DateScrollerView: View {

    @EnvironmentObject var dateHolder: DateHolder
    var body: some View {
        HStack{
            Spacer()
//            Button(action: {
//                previousMonth()
//            }, label: {
//                Image(systemName: "arrow.left")
//                    .imageScale(.medium)
//                    .font(Font.title.weight(.bold))
//            })
            Text(CalendarHelper().monthYearString(dateHolder.date))
                .font(.title3)
                .bold()
                .animation(.none)
                .frame(maxWidth: .infinity) // MARK: COME HERE TO CHANGE FRAME
//            Button(action: {
//                nextMonth()
//            }, label: {
//                Image(systemName: "arrow.right")
//                    .imageScale(.medium)
//                    .font(Font.title.weight(.bold))
//            })
            Spacer()
        }
    }
    
    func previousMonth(){
        dateHolder.date = CalendarHelper().minusMonth(dateHolder.date)
    }
    func nextMonth(){
        dateHolder.date = CalendarHelper().plusMonth(dateHolder.date)
    }
}

//#Preview {
//    DateScrollerView()
//}
