//
//  StatsView.swift
//  Gym1.1
//
//  Created by Sky Quan on 2023-12-30.
//

import SwiftUI

struct StatsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \DaysWorkedOut.dates, ascending: false)],
        animation: .default)
    private var dates: FetchedResults<DaysWorkedOut>
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \MuscleGroup.dateCreated, ascending: false)],
        animation: .default)
    private var items: FetchedResults<MuscleGroup>
    
    var body: some View {
        NavigationStack{
            title
            ScrollView{
                Text("View Weight Progression")
                    .frame(maxWidth: 320, alignment: .leading)
                    .font(.headline)
                    .padding(.top)
                ForEach(items){ muscleGoup in
                    NavigationLink {
                        StatsGraphView(muscleGroup: muscleGoup)
                    } label: {
                        indMuscleGroupView(indMG: muscleGoup)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                Text("Days went to the gym")
                    .frame(maxWidth: 320, alignment: .leading)
                    .font(.headline)
                    .padding(.top)
                calendar
            }
        }
        .tint(Color("Custom5"))
    }
    
    var title: some View{
        ZStack(alignment: .top){
            Rectangle()
                .foregroundStyle(Color("Custom6"))
                .ignoresSafeArea(.all)
                .frame(maxHeight: 90)
            Text("Stats")
                .font(.title)
                .bold()
                .padding()
                .frame(maxWidth: .infinity, alignment: .center)
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

    var calendar: some View{
        RoundedRectangle(cornerRadius: 15)
            .fill(Color("Custom1"))
            .frame(width: 350, height: 370, alignment: .center)
            .overlay {
                let dateHolder = DateHolder()
                return CalendarView(dates: dates.count != 0 ? dates[0].dates : [], statsView: true)
                    .environmentObject(dateHolder)
                    .padding(.horizontal)
                    .padding(.bottom, 30)
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
    StatsView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
