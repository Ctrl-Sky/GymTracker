//
//  StatsGraphView.swift
//  Gym1.1
//
//  Created by Sky Quan on 2023-12-30.
//

import SwiftUI

struct StatsGraphView: View {
    
    @Environment(\.managedObjectContext) private var moc

    private var fetchRequest : FetchRequest<Workout>
    private var workouts: FetchedResults<Workout> {
        fetchRequest.wrappedValue
    }
    @StateObject private var muscleGroup: MuscleGroup

    init(muscleGroup: MuscleGroup) {
        fetchRequest = FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Workout.order, ascending: true)], predicate: NSPredicate(format: "relationship == %@", muscleGroup), animation: .default)
        _muscleGroup = StateObject(wrappedValue: muscleGroup)
    }
    
    var body: some View {
        NavigationStack{
            title
            VStack{
                ScrollView{
                    ForEach(workouts){ workout in
                        LineGraphView(workout: workout, setView: true)
                    }
                }
            }
            .toolbar{
                ToolbarItem{
                    searchButton
                }
                ToolbarItem{
                    settingsButton
                }
            }
        }
        
    }
    
    var title: some View{
        ZStack(alignment: .top){
            Rectangle()
                .foregroundStyle(Color("Custom6"))
                .ignoresSafeArea(.all)
                .frame(maxHeight: 90)
            Text("Weight Progression")
                .font(.title)
                .bold()
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    var searchButton: some View{
        Button(action: {
            // TODO: Create search bar
        }, label: {
            Image(systemName: "magnifyingglass")
        })
    }
    
    var settingsButton: some View{
        Button {
            // TODO: Add settings
        } label: {
            Image(systemName: "gearshape")
        }
    }
}

#Preview {
    StatsGraphView(muscleGroup: MuscleGroup.preview()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
