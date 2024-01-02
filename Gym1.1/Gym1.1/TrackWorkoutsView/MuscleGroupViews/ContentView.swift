//
//  ContentView.swift
//  Gym1.1
//
//  Created by Sky Quan on 2023-12-12.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.colorScheme) var colorScheme

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \MuscleGroup.dateAccessed, ascending: false)],
        animation: .default)
    private var items: FetchedResults<MuscleGroup>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \DaysWorkedOut.dates, ascending: false)],
        animation: .default)
    private var dates: FetchedResults<DaysWorkedOut>

    
    @State private var errorAlert: Bool = false
    @State private var showingAlert: Bool = false
    @State private var editButton: Bool = false
    @State private var name = ""

    
    var body: some View {
        NavigationStack {
            VStack{
                title
                ScrollView{
                    calendar
                    HStack{
                        Text("Workouts")
                            .font(.headline)
                        Spacer()
                        addButton
                            .alert("Muscle Group Name", isPresented: $showingAlert) {
                                TextField("Name", text: $name)
                                    .foregroundStyle(colorScheme == .dark ? .white : .black)
                                Button("Cancel", role: .cancel){}
                                Button("Submit", action: {addItem(name: name)})
                            } message: {
                                Text("Enter the name of the muscle group you want to add")
                            }
                        deleteButton
                    }
                    .frame(maxWidth: 320)
                    if items.isEmpty{
                        noWorkouts
                    }
                    ForEach(items) { item in
                        NavigationLink {
                            WorkoutView(muscleGroup: item)
                                .onAppear {
                                    updateDateAccessed(muscleGroup: item)
                                }
                        } label: {
                            ZStack{
                                indMuscleGroupView(indMG: item)
                                    .opacity(editButton ? 0.3 : 1.0)
                                if editButton{
                                    Image(systemName: "minus.circle.fill")
                                        .foregroundStyle(.red)
                                        .onTapGesture {
                                            deleteItems(muscleGroup: item)
                                        }
                                }
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .navigationBarTitle(Text(""), displayMode: .inline)
                .scrollDismissesKeyboard(.interactively)
                Spacer()
            }
            .toolbar{
                ToolbarItem{
                    searchButton
                }
                ToolbarItem{
                    settingsButton
                }
            }
            .alert("Could not save data", isPresented: $errorAlert) {
                Button("Ok", role: .cancel){}
            } message: {
                Text("There was a problem saving your data but it is not your fault. If you restart the app, you can try again. Please contact me on my github (Ctrl-Sky) to notify me of this issue.")
            }
        }
        .tint(Color("Custom2"))
    }
    
    var title: some View{
        ZStack(alignment: .top){
            Rectangle()
                .foregroundStyle(Color("Custom4"))
                .ignoresSafeArea(.all)
                .frame(maxHeight: 90)
            Text("Muscle Groups")
                .font(.title)
                .bold()
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
    
    var calendar: some View{
        let dateHolder = DateHolder()
        return CalendarView(dates: dates.count != 0 ? dates[0].dates : [])
            .environmentObject(dateHolder)
            .padding(.horizontal)
            .padding(.bottom, 30)
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
    
    var noWorkouts: some View {
        VStack{
            Image(systemName: "arrow.up")
                .padding(.leading, 215)
                .padding(.top, 10)
            Text("Oh no it's empty, add some more workouts")
                .padding(.top, 20)
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
    
    
    private func addItem(name: String) {
        withAnimation {
            let newMuscleGroup = MuscleGroup(context: viewContext)
            newMuscleGroup.name = name
            newMuscleGroup.dateCreated = Date.now
            self.name = ""

            do {
                try viewContext.save()
            } catch {
                viewContext.delete(newMuscleGroup)
                errorAlert.toggle()
            }
        }
    }

    private func deleteItems(muscleGroup: MuscleGroup) {
        withAnimation {
            viewContext.delete(muscleGroup)
            do {
                try viewContext.save()
            } catch {
                viewContext.insert(muscleGroup)
                errorAlert.toggle()
            }
        }
    }
    
    private func updateDateAccessed(muscleGroup: MuscleGroup){
        muscleGroup.dateAccessed = Date.now
        do {
            try viewContext.save()
        } catch {
            errorAlert.toggle()
        }

    }
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
