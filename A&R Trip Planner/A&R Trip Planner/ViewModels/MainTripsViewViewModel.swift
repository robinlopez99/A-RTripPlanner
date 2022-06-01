//
//  MainTripsViewViewModel.swift
//  A&R Trip Planner
//
//  Created by Robin Lopez Ordonez on 2/9/22.
//

import Foundation

class MainTripsViewViewModel {
    var dateFormatter = DateFormatter()
    var trips: [Trip]
    
    init(trips: [Trip]) {
        dateFormatter.dateFormat = "MMM dd, YYYY"
        self.trips = trips
    }
    
    func today() -> String {
        return dateFormatter.string(from: Date())
    }
    
    static func getMockTrips() -> [Trip] {
        let trip1 = Trip(name: "Cook", location: "Milford, CT", startDate: "2/12", endDate: "2/12", totalAmount: 300, budget: 300, activities: [])
        let trip2 = Trip(name: "Aire", location: "New York City, NY", startDate: "2/25", endDate: "2/25", totalAmount: 700, budget: 700, activities: [])
        let trip3 = Trip(name: "Ph", location: "Philippines", startDate: "2/26", endDate: "May", totalAmount: 0, budget: 0, activities: [])
        let trip4 = Trip(name: "Ph", location: "Philippines", startDate: "2/26", endDate: "May", totalAmount: 0, budget: 0, activities: [])
        let trip5 = Trip(name: "Ph", location: "Philippines", startDate: "2/26", endDate: "May", totalAmount: 0, budget: 0, activities: [])
        let trip6 = Trip(name: "Ph", location: "Philippines", startDate: "2/26", endDate: "May", totalAmount: 0, budget: 0, activities: [])
        let trip7 = Trip(name: "Ph", location: "Philippines", startDate: "2/26", endDate: "May", totalAmount: 0, budget: 0, activities: [])
        let trip8 = Trip(name: "Ph", location: "Philippines", startDate: "2/26", endDate: "May", totalAmount: 0, budget: 0, activities: [])
        
        return [trip1, trip2, trip3,trip4, trip5, trip6,trip7, trip8]
        //return [trip1]
    }
}
