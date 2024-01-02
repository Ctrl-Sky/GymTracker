//
//  MuscleGroup+CoreDataProperties.swift
//  Gym1.1
//
//  Created by Sky Quan on 2023-12-12.
//
//

import Foundation
import CoreData


extension MuscleGroup {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MuscleGroup> {
        return NSFetchRequest<MuscleGroup>(entityName: "MuscleGroup")
    }

    @NSManaged public var name: String
    @NSManaged public var dateCreated: Date?
    @NSManaged public var dateAccessed: Date
    @NSManaged public var workouts: NSSet

}

// MARK: Generated accessors for workouts
extension MuscleGroup {

    @objc(addWorkoutsObject:)
    @NSManaged public func addToWorkouts(_ value: Workout)

    @objc(removeWorkoutsObject:)
    @NSManaged public func removeFromWorkouts(_ value: Workout)

    @objc(addWorkouts:)
    @NSManaged public func addToWorkouts(_ values: NSSet)

    @objc(removeWorkouts:)
    @NSManaged public func removeFromWorkouts(_ values: NSSet)

}

extension MuscleGroup : Identifiable {

}
