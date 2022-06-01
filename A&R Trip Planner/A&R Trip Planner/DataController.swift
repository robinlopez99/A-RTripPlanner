//
//  DataController.swift
//  A&R Trip Planner
//
//  Created by Robin Lopez Ordonez on 2/19/22.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "TripObject")
    
    static var preview: DataController = {
        let controller = DataController(inMemory: true)

        return controller
    }()
    
    init(inMemory: Bool = false) {
        if inMemory {
            container.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.loadPersistentStores { desc, error in
            if let _ = error {
                fatalError()
            }
        }
    }
    
    
}
