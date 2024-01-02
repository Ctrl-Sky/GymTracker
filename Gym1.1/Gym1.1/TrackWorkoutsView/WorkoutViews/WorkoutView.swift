//
//  ContentView.swift
//  Gym1.1
//
//  Created by Sky Quan on 2023-12-12.
//

import SwiftUI
import CoreData
import Charts

struct WorkoutView: View {
    @Environment(\.colorScheme) var colorScheme
    @Environment(\.managedObjectContext) private var moc

    private var fetchRequest : FetchRequest<Workout>
    private var workouts: FetchedResults<Workout> {
        fetchRequest.wrappedValue
    }
    @StateObject private var muscleGroup: MuscleGroup

    init(muscleGroup: MuscleGroup) {
        fetchRequest = FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Workout.order, ascending: true)],
        predicate: NSPredicate(format: "relationship == %@", muscleGroup),
        animation: .default)
        _muscleGroup = StateObject(wrappedValue: muscleGroup)
    }
    
    @State private var errorAlert: Bool = false
    @State private var showingAlert : Bool = false
    @State private var editButton: Bool = false
    @State private var showGraphs: Bool = false
    @State private var name : String = ""
    @State private var numOfSets: String = ""
    @FocusState private var focusedField: Bool

    var body: some View {
        NavigationStack {
            VStack{
                title
                ScrollView{
                    HStack{
                        Text("Exercises")
                            .font(.headline)
                        Spacer()
                        addButton
                            .alert("Workout name and number of sets", isPresented: $showingAlert) {
                                TextField("Workout", text: $name)
                                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                                TextField("Number of sets", text: $numOfSets)
                                    .keyboardType(.numberPad)
                                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                                Button("Cancel", role: .cancel){}
                                Button("Submit", action: {addItem(name: name, numOfSets: Int64(numOfSets) ?? 3)})
                            } message: {
                                Text("Enter the name of the workout and the planned number of sets")
                            }
                        deleteButton
                    }
                    .frame(maxWidth: 320)
                    if workouts.isEmpty{
                        noExercises
                    }
                    listOfWorkouts
                    if workouts.count != 0{
                        Text("Weight Tracker")
                            .font(.headline)
                            .frame(maxWidth: 320, alignment: .leading)
                            .padding(.top)
                        if showGraphs == false{
                            
                            singleGraph
                        }
                        else{
                            listOfGraphs
                        }
                    }
                }
                .navigationBarTitle(Text(""), displayMode: .inline)
                .toolbar{
                    ToolbarItem{
                        searchButton
                    }
                    ToolbarItem{
                        settingsButton
                    }
                }
                .scrollDismissesKeyboard(.interactively)
            }
            .alert("Could not save data", isPresented: $errorAlert) {
                Button("Ok", role: .cancel){}
            } message: {
                Text("There was a problem saving your data but it is not your fault. If you restart the app, you can try again. Please contact me on my github (Ctrl-Sky) to notify me of this issue.")
            }
        }
    }
    
    var title: some View{
        ZStack(alignment: .top){
            Rectangle()
                .foregroundStyle(Color("Custom4"))
                .ignoresSafeArea(.all)
                .frame(maxHeight: 90)
            TextField("Rename Muscle Group", text: $muscleGroup.name)
                .font(.title)
                .bold()
                .padding()
                .multilineTextAlignment(.center)
                .focused($focusedField)
                .onSubmit() {
                    do{
                        try moc.save()
                    }
                    catch{
                        muscleGroup.name = ""
                        errorAlert.toggle()
                    }
                }
        }
        .padding(.bottom)
    }
    var addButton: some View{
        Button(action: {
            showingAlert.toggle()
        }, label: {
            Image(systemName: "plus")
                .foregroundStyle(Color("Custom3"))
        })
        .padding(.trailing)
    }
    var deleteButton: some View{
        Button(action: {withAnimation{editButton.toggle()}}, label: {
            Image(systemName: editButton ? "trash.fill" : "trash")
                .foregroundStyle(Color("Custom3"))
        })
    }
    var noExercises: some View{
        VStack{
            Image(systemName: "arrow.up")
                .offset(CGSize(width: 108.0, height: 20.0))
            Text("Oh no it's empty, add some more exercises")
                .offset(CGSize(width: 10.0, height: 50))
        }
    }
    var listOfWorkouts: some View{
        ForEach(workouts) { workout in
            NavigationLink {
                SetsView(workout: workout, numOfSets: Int(workout.numOfSets))
                    .onAppear {
                        updateDateAccessed(workout: workout)
                    }
            } label: {
                ZStack{
                    indWorkoutView(indW: workout)
                        .opacity(editButton ? 0.3 : 1.0)
                    if editButton{
                        Image(systemName: "minus.circle.fill")
                            .foregroundStyle(.red)
                            .onTapGesture {
                                deleteItems(workout: workout)
                            }
                    }
                }
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
    var singleGraph: some View{
        VStack{
            LineGraphView(workout: workouts[0] )
            Button(action: {
                showGraphs = true
            }, label: {
                Text("show more")
                    .foregroundStyle(.secondary)
                    .foregroundStyle(.gray)
            })
            .padding(.top)
        }
    }
    var listOfGraphs: some View{
        VStack{
            ForEach(workouts){ workout in
                LineGraphView(workout: workout)
            }
            Button(action: {
                showGraphs = false
            }, label: {
                Text("show less")
                    .foregroundStyle(.secondary)
                    .foregroundStyle(.gray)
            })
            .padding(.top)
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
    
    private func addItem(name: String, numOfSets: Int64){
        withAnimation {
            let newWorkout = Workout(context: moc)
            newWorkout.name = name
            newWorkout.numOfSets = numOfSets
            newWorkout.dateAccessed = Date.now
            newWorkout.order = Int64(Set(workouts).count)
            newWorkout.relationship = muscleGroup
            self.name = ""
            self.numOfSets = ""
            do{
                try moc.save()
            } catch {
                moc.delete(newWorkout)
                errorAlert.toggle()
            }
        }
    }


    private func deleteItems(workout: Workout) {
        withAnimation {
            moc.delete(workout)
            do {
                try moc.save()
            } catch {
                moc.insert(workout)
                errorAlert.toggle()
            }
        }
    }
    
    private func updateDateAccessed(workout: Workout){
        workout.dateAccessed = Date.now
        do{
            try moc.save()
        }
        catch{
            errorAlert.toggle()
        }
    }
}

#Preview {
    NavigationStack{
        WorkoutView(muscleGroup: MuscleGroup.preview()).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
