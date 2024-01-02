//
//  TabView.swift
//  Gym1.1
//
//  Created by Sky Quan on 2023-12-30.
//

import SwiftUI

struct MainView: View {
    @Environment(\.managedObjectContext) private var viewContext
    var body: some View {
        TabView{
            ContentView()
                .tabItem {
                    Image(systemName: "dumbbell")
                    Text("Workouts")
                }
            StatsView()
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("Stats")
                }
        }
    }
}

#Preview {
    MainView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
