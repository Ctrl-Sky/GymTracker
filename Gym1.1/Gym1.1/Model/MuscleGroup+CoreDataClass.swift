//
//  MuscleGroup+CoreDataClass.swift
//  Gym1.1
//
//  Created by Sky Quan on 2023-12-12.
//
//

import Foundation
import CoreData

@objc(MuscleGroup)
public class MuscleGroup: NSManagedObject {

}

extension MuscleGroup{
    
    @discardableResult
    static func preview(context: NSManagedObjectContext = PersistenceController.preview.container.viewContext) -> MuscleGroup{
        let muscleGroup = MuscleGroup(context: context)
        muscleGroup.name = "Leg"
        muscleGroup.dateCreated = Date.now
        
        for i in 0...2 {
            let workout = Workout(context: context)
            workout.name = "Workout\(i)"
            workout.numOfSets = 3
            workout.dateAccessed = Date.now.addingTimeInterval(TimeInterval(i))
            workout.order = Int64(i)
            for j in 1...3 {
                let set = Sets(context: context)
                set.reps = ["\(j)","\(j)","\(j)"]
                set.weights = ["\(j)","\(j)","\(j)"]
                set.addWeight = false
                set.relationship = workout
                set.dateOfCreation = Date.now.addingTimeInterval(TimeInterval(i))
            }
            workout.relationship = muscleGroup
        }
        
        return muscleGroup
    }
    
}
