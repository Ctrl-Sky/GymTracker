//
//  DaysWorkedOut+CoreDataProperties.swift
//  Gym1.1
//
//  Created by Sky Quan on 2023-12-29.
//
//

import Foundation
import CoreData


extension DaysWorkedOut {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DaysWorkedOut> {
        return NSFetchRequest<DaysWorkedOut>(entityName: "DaysWorkedOut")
    }

    @NSManaged public var dates: [Date]

}

extension DaysWorkedOut : Identifiable {

}
