//
//  Trip.swift
//  A&R Trip Planner
//
//  Created by Robin Lopez Ordonez on 2/9/22.
//

import Foundation

struct Trip: Identifiable {
    var id = UUID()
    var name: String
    var location: String
    var startDate: String
    var endDate: String
    var totalAmount: Double
    var budget: Double
    var activities: [Activity]
}

struct Activity: Identifiable {
    var id = UUID()
    var name: String
    var location: String
    var price: Double
    var time: String
}
