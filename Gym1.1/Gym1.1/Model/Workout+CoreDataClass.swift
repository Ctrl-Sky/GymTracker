//
//  Workout+CoreDataClass.swift
//  Gym1.1
//
//  Created by Sky Quan on 2023-12-14.
//
//

import Foundation
import CoreData

@objc(Workout)
public class Workout: NSManagedObject {
    
    @discardableResult
    static func preview(context: NSManagedObjectContext = PersistenceController.preview.container.viewContext) -> Workout{
        let workout = Workout(context: context)
        workout.name = "Bench Press"
        workout.numOfSets = 3
        
        let calender = Calendar.current
        let set1 = Sets(context: context)
        set1.reps = ["8","8","8"]
        set1.weights = ["45","45","45"]
        set1.addWeight = false
        set1.relationship = workout
        let dateComponents1 = DateComponents(year: 2022, month: 12, day: 22, hour: 10, minute: 49)
        set1.dateOfCreation = calender.date(from: dateComponents1) ?? Date.now
        
        let set2 = Sets(context: context)
        set2.reps = ["5","5","5"]
        set2.weights = ["65","65","65"]
        set2.addWeight = false
        set2.relationship = workout
        let dateComponents2 = DateComponents(year: 2022, month: 11, day: 21, hour: 9, minute: 47)
        set2.dateOfCreation = calender.date(from: dateComponents2) ?? Date.now
        
        return workout
    }
}
