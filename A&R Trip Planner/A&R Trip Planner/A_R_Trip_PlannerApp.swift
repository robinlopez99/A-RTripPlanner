//
//  A_R_Trip_PlannerApp.swift
//  A&R Trip Planner
//
//  Created by Robin Lopez Ordonez on 2/4/22.
//

import SwiftUI

@main
struct A_R_Trip_PlannerApp: App {
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            OpeningView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environment(\.colorScheme, .light)
        }
    }
}
