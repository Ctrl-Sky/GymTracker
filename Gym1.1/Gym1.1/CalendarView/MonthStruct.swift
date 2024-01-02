//
//  MonthStruct.swift
//  Gym1.1
//
//  Created by Sky Quan on 2023-12-28.
//

import Foundation

struct MonthStruct{
    var monthType: MonthType
    var dayInt: Int
    func day() -> String{
        return String(dayInt)
    }
}

enum MonthType{
    case Previous
    case Current
    case Next
}
