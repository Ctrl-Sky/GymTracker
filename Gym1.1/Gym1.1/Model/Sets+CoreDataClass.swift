//
//  Sets+CoreDataClass.swift
//  Gym1.1
//
//  Created by Sky Quan on 2023-12-17.
//
//

import Foundation
import CoreData

@objc(Sets)
public class Sets: NSManagedObject{
    
    @discardableResult
    static func preview(context: NSManagedObjectContext = PersistenceController.preview.container.viewContext) -> Sets{
        let set1 = Sets(context: context)
        set1.reps = ["8","8","8"]
        set1.weights = ["45","45","45"]
        set1.addWeight = false
        set1.notes = "Focus Left"
        let calender = Calendar.current
        let dateComponents1 = DateComponents(year: 2022, month: 12, day: 22, hour: 10, minute: 49)
        set1.dateOfCreation = calender.date(from: dateComponents1) ?? Date.now
        
        return set1
    }
}
