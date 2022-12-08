//
//  FlightTrackerApp.swift
//  FlightTracker
//
//  Created by Dorra Ben Abdelwahed on 7/12/2022.
//

import SwiftUI

@main
struct FlightTrackerApp: App {
    
    @StateObject private var manager: DataManager = DataManager()

    var body: some Scene {
        WindowGroup {
            
            HomeView()
                .environmentObject(manager)
                .environment(\.managedObjectContext, manager.container.viewContext)
        }
    }
}
