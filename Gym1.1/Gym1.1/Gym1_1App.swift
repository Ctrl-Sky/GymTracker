//
//  Gym1_1App.swift
//  Gym1.1
//
//  Created by Sky Quan on 2023-12-12.
//

import SwiftUI

@main
struct Gym1_1App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            MainView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
                .preferredColorScheme(.light)
        }
    }
}
