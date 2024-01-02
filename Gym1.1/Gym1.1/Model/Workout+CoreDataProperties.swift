//
//  Workout+CoreDataProperties.swift
//  Gym1.1
//
//  Created by Sky Quan on 2023-12-14.
//
//

import Foundation
import CoreData


extension Workout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
        return NSFetchRequest<Workout>(entityName: "Workout")
    }

    @NSManaged public var name: String
    @NSManaged public var numOfSets: Int64
    @NSManaged public var dateAccessed: Date
    @NSManaged public var order: Int64
    @NSManaged public var relationship: MuscleGroup
    @NSManaged public var sets: NSSet
}

// MARK: Generated accessors for sets
extension Workout {

    @objc(addSetsObject:)
    @NSManaged public func addToSets(_ value: Sets)

    @objc(removeSetsObject:)
    @NSManaged public func removeFromSets(_ value: Sets)

    @objc(addSets:)
    @NSManaged public func addToSets(_ values: NSSet)

    @objc(removeSets:)
    @NSManaged public func removeFromSets(_ values: NSSet)

}

extension Workout : Identifiable {

}
