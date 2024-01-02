//
//  SetsView.swift
//  Gym1.1
//
//  Created by Sky Quan on 2023-12-14.
//

import SwiftUI

struct SetsView: View {
    @Environment(\.managedObjectContext) private var moc
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \DaysWorkedOut.dates, ascending: false)],
        animation: .default)
    private var dates: FetchedResults<DaysWorkedOut>
    
    private var fetchRequest : FetchRequest<Sets>
    private var sets : FetchedResults<Sets> {
        fetchRequest.wrappedValue
    }
    
    init(workout: Workout, numOfSets: Int){
        fetchRequest = FetchRequest(sortDescriptors: [NSSortDescriptor(keyPath: \Sets.dateOfCreation, ascending: false)], predicate: NSPredicate(format: "relationship == %@", workout), animation: .default)
        self.numOfSets = numOfSets
        _workout = StateObject(wrappedValue: workout)
    }
    
    @StateObject private var workout: Workout
    private var numOfSets: Int
    @State private var editButton: Bool = false
    @State private var errorAlert: Bool = false
    @FocusState private var focusedField: Bool
    
    var body: some View {
        NavigationStack{
            VStack{
                title
                HStack{
                    Text("Sets")
                        .font(.headline)
                    Spacer()
                    addButton
                    deleteButton
                }
                .frame(maxWidth: 320)
                dividerLine
                if sets.isEmpty{
                    noSets
                }
                ScrollView{
                    listOfSets
                }
                .toolbar{
                    ToolbarItem{
                        searchButton
                    }
                    ToolbarItem{
                        settingsButton
                    }
                }
                .scrollDismissesKeyboard(.interactively)
                .navigationBarTitle(Text(""), displayMode: .inline)
            }
            .alert("Could not save data", isPresented: $errorAlert) {
                Button("Ok", role: .cancel){}
            } message: {
                Text("There was a problem saving your data but it is not your fault. If you restart the app, you can try again. Please contact me on my github (Ctrl-Sky) to notify me of this issue.")
            }
            Spacer()
        }
    }
    var title: some View{
        ZStack(alignment: .top){
            Rectangle()
                .foregroundStyle(Color("Custom4"))
                .ignoresSafeArea(.all)
                .frame(maxHeight: 90)
            TextField("Rename Workout", text: $workout.name)
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
                        workout.name = ""
                        errorAlert.toggle()
                    }
                }
        }
        .padding(.bottom)
    }
    var addButton: some View{
        Button(action: {
            addItem()
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
    var dividerLine: some View{
        Rectangle()
            .frame(width: 350, height: 1, alignment: .center)
            .padding(.top)
            .foregroundStyle(Color("Custom3"))
    }
    var noSets: some View{
        VStack{
            Image(systemName: "arrow.up")
                .offset(CGSize(width: 108.0, height: 20.0))
            Text("Oh no it's empty, add some more workouts")
                .offset(CGSize(width: 10.0, height: 50))
        }
    }
    var listOfSets: some View{
        ForEach(sets){ set in
            ZStack{
                IndSetView(indSet: set, numOfSets: Int(workout.numOfSets))
                    .opacity(editButton ? 0.3 : 1.0)
                    .padding(.vertical)
                if editButton{
                    Button {
                        deleteSets(set: set)
                    } label: {
                        Image(systemName: "minus.circle.fill")
                            .foregroundStyle(.red)
                    }
                }
            }
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
    
    private func addItem(){
        withAnimation{
            let newSet = Sets(context: moc)
            newSet.addWeight = false
            newSet.reps = Array(repeating: "", count: Int(numOfSets))
            newSet.weights = Array(repeating: "", count: Int(numOfSets))
            newSet.relationship = workout
            newSet.dateOfCreation = Date.now
            
            addDaysWorkedOut()
            
            do{
                try moc.save()
            } catch {
                moc.delete(newSet)
                errorAlert.toggle()
            }
        }
    }
    
    private func deleteSets(set: Sets) {
        withAnimation{
            moc.delete(set)
            do {
                try moc.save()
            } catch {
                moc.insert(set)
                errorAlert.toggle()
            }
        }
    }
    
    private func addDaysWorkedOut(){
        if dates.count == 0{
            let newDates = DaysWorkedOut(context: moc)
            newDates.dates.append(Date.now)
        }
        else{
            dates[0].dates.append(Date.now)
        }
    }
}

#Preview {
    NavigationStack{
        SetsView(workout: Workout.preview(), numOfSets: Int(Workout.preview().numOfSets)).environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
