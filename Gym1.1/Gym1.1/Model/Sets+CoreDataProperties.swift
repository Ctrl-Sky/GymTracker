//
//  Sets+CoreDataProperties.swift
//  Gym1.1
//
//  Created by Sky Quan on 2023-12-17.
//
//

import Foundation
import CoreData


extension Sets {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Sets> {
        return NSFetchRequest<Sets>(entityName: "Sets")
    }

    @NSManaged public var reps: [String]
    @NSManaged public var weights: [String]
    @NSManaged public var addWeight: Bool
    @NSManaged public var relationship: Workout
    @NSManaged public var notes: String
    @NSManaged public var dateOfCreation: Date

}

extension Sets : Identifiable {

}
