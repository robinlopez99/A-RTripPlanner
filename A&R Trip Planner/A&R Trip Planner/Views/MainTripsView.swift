//
//  MainTripsView.swift
//  A&R Trip Planner
//
//  Created by Robin Lopez Ordonez on 2/4/22.
//

import SwiftUI

struct MainTripsView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var trips: FetchedResults<TripObject>
    
    var vm = MainTripsViewViewModel(trips: MainTripsViewViewModel.getMockTrips())
    
    init() {
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.backgroundColor = UIColor(Color.aeonPink)
        coloredAppearance.shadowColor = .clear

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
        
        UITableView.appearance().backgroundColor = .clear
    }
    
    var body: some View {
        ZStack {
            Color.aeonPink
                .ignoresSafeArea()
            
            VStack(alignment: .center) {
                NavigationLink(destination: NewTripView().environment(\.managedObjectContext, moc), label: {
                    Label("Add New Trip", systemImage: "plus.circle")
                        .frame(width: 200, height: 50, alignment: .center)
                        .foregroundColor(.black)
                        .overlay(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(.black, lineWidth: 1)
                            )
                })
                TripsListView(trips: trips)
                    .environment(\.managedObjectContext, moc)
                
                Label("always remember that i love you", systemImage: "heart.fill")
                    .labelStyle(TwoImageLabelStyle())
            }
            .padding(10)
        }
        .navigationBarHidden(false)
        .navigationTitle("Trips")
    }
}

struct TripsListView: View {
    @Environment(\.managedObjectContext) var moc
    var trips: FetchedResults<TripObject>
    
    var body: some View {
        if trips.isEmpty {
            List {
                Text("No Trips Yet!")
                    .padding(.vertical, 10)
            }
        } else {
            List {
                ForEach(trips, id: \.id)  { trip in
                    NavigationLink(destination: TripDetailView(trip: trip).environment(\.managedObjectContext, moc), label: {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(trip.name ?? "")
                                    .font(.title3)
                                Text(trip.location ?? "")
                                    .font(.caption)
                            }
                            .padding(.vertical, 10)
                            
                            Spacer()
                            
                            Text("\(trip.startDate ?? "") - \(trip.endDate ?? "")")
                        }
                    })
                }.onDelete(perform: deleteTrip)
            }
        }
    }
    
    func deleteTrip(at offsets: IndexSet) {
        for index in offsets {
            let trip = trips[index]
            moc.delete(trip)
            try? moc.save()
        }
    }
}



struct MainTripsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainTripsView()
        }
        .navigationBarBackButtonHidden(false)
    }
}
