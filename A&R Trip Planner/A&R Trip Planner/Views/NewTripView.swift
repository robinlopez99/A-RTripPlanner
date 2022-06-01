//
//  NewTripView.swift
//  A&R Trip Planner
//
//  Created by Robin Lopez Ordonez on 2/9/22.
//

import SwiftUI

struct NewTripView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var location: String = ""
    @State private var startDate: String = ""
    @State private var endDate: String = ""
    @State private var budget: String = ""
    @State private var notes: String = ""
    
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

            VStack {
                Form {
                    TextField("Name", text: $name)
                        .submitLabel(.done)
                    TextField("Location", text: $location)
                        .submitLabel(.done)
                    TextField("Start Date", text: $startDate)
                        .submitLabel(.done)
                    TextField("End Date", text: $endDate)
                        .submitLabel(.done)
                    TextField("Budget", text: $budget)
                        .keyboardType(.numberPad)
                    
                }
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            hideKeyboard()
                        }
                    }
                }
                
                VStack(alignment: .leading) {
                    Text("Notes")
                    TextEditor(text: $notes)
                        .cornerRadius(15)
                        .submitLabel(.done)
                }
                .padding(.horizontal, 25)
                .padding(.bottom, 25)
                
                Label("Save New Trip", systemImage: "checkmark.icloud.fill")
                    .padding(15)
                    .foregroundColor(.black)
                    .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.black, lineWidth: 1)
                        )
                    .onTapGesture {
                        createNewTrip()
                        dismiss()
                    }
                
                Spacer()

            }
        }
        .navigationBarHidden(false)
        .navigationTitle("New Trip")
        .accentColor(Color.lightPurple)
    }
    
    private func createNewTrip() {
        if name == "" && location == "" && startDate == "" && endDate == "" && budget == "" && notes == "" {
            return
        }
        let trip = TripObject(context: moc)
        trip.id = UUID()
        trip.name = name
        trip.location = location
        trip.startDate = startDate
        trip.endDate = endDate
        trip.budget = Double(budget) ?? 0
        trip.notes = notes
        try? moc.save()
    }
}

struct NewTripView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            NewTripView()
        }
    }
}
