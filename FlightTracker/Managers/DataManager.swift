//
//  DataManager.swift
//  FlightTracker
//
//  Created by Dorra Ben Abdelwahed on 8/12/2022.
//

import CoreData
import Foundation

/// Main data manager to handle the todo items
class DataManager: NSObject, ObservableObject {
    /// Dynamic properties that the UI will react to
    
    
    /// Add the Core Data container with the model name
    let container: NSPersistentContainer = NSPersistentContainer(name: "Model")
    
    /// Default init method. Load the Core Data container
    override init() {
        super.init()
        container.loadPersistentStores { _, _ in }
    }
}
