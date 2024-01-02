//
//  Persistence.swift
//  Gym1.1
//
//  Created by Sky Quan on 2023-12-12.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        
        let mgName: [String] = ["Leg", "Chest", "Back"]
                
        for i in 0...2{
            let muscleGroup = MuscleGroup(context: viewContext)
            muscleGroup.name = mgName[i]
            muscleGroup.dateCreated = Date.now
            muscleGroup.dateAccessed = Date.now.addingTimeInterval(TimeInterval(i))
            for j in 0...2{
                let workout = Workout(context: viewContext)
                workout.name = "\(muscleGroup.name)\(j)"
                workout.numOfSets = 3
                for k in 0...2{
                    let set = Sets(context: viewContext)
                    set.reps = ["j","j","j"]
                    set.weights = ["j","j","j"]
                    set.addWeight = false
                    set.relationship = workout
                }
                workout.relationship = muscleGroup
            }
        }
        
        func createDate(year: Int, month: Int, day: Int) -> Date {
            var components = DateComponents()
            components.year = year
            components.month = month
            components.day = day

            let calendar = Calendar.current

            return calendar.date(from: components)!
        }
        
        let newDaysWorkedOut = DaysWorkedOut(context: viewContext)
        newDaysWorkedOut.dates = [createDate(year: 2023, month: 12, day: 14), createDate(year: 2023, month: 12, day: 19), createDate(year: 2023, month: 12, day: 1)]

        
        do {
            try viewContext.save()
        } catch {
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "Gym1_1")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }
}
