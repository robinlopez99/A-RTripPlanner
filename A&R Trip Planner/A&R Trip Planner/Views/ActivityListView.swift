//
//  SimpleEditView.swift
//  A&R Trip Planner
//
//  Created by Robin Lopez Ordonez on 2/19/22.
//

import SwiftUI

struct ActivityListView: View {
    var trip: TripObject
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = ""
    @State private var location: String = ""
    @State private var date: String = ""
    @State private var price: String = ""
    @State private var duration: String = ""
    @State private var link: String = ""
    
    init(trip: TripObject) {
        self.trip = trip
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
            
            let activities = trip.activities?.allObjects as! [ActivityObject]
            
            VStack {
                if activities.isEmpty {
                    List {
                        Text("No Activities Yet!")
                            .padding(.vertical, 10)
                    }
                } else {
                    List {
                        ForEach(activities, id: \.id) { activity in
                            VStack {
                                HStack {
                                    VStack(alignment: .leading) {
                                        Text("Name: \(activity.name ?? "")")
                                        Text("Location: \(activity.location ?? "")")
                                        Text("Date: \(activity.date ?? "")")
                                    }
                                    Spacer()
                                    VStack(alignment: .trailing) {
                                        let price: String = String(activity.price)
                                        Text("Price: \(price) ")
                                        Text("Durantion: \(activity.time ?? "")")
                                    }
                                    
                                }
                                Text(activity.link ?? "No Link")
                                    .font(.headline)
                                    .padding(.bottom, 10)
                            }
                        }.onDelete(perform: removeActivity)
                    }
                }
                
                Form {
                    TextField("Name", text: $name)
                        .submitLabel(.done)
                    TextField("Location", text: $location)
                        .submitLabel(.done)
                    TextField("Date", text: $date)
                        .submitLabel(.done)
                    TextField("Duration", text: $duration)
                        .submitLabel(.done)
                    TextField("Price", text: $price)
                        .keyboardType(.numberPad)
                    TextField("Link", text: $link)
                        .submitLabel(.done)
                }
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()

                        Button("Done") {
                            hideKeyboard()
                        }
                    }
                }
                .accentColor(Color.lightPurple)
                
                Label("Save New Activity", systemImage: "checkmark.icloud.fill")
                    .padding()
                    .foregroundColor(.black)
                    .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.black, lineWidth: 1)
                        )
                    .onTapGesture {
                        saveNewActivity()
                    }
            }
            
            
        }
        .navigationBarTitle("Activities")
    }
    
    
    func removeActivity(at offsets: IndexSet) {
        let activities = trip.activities?.allObjects as! [ActivityObject]
        
        for index in offsets {
            let activity = activities[index]
            moc.delete(activity)
            try? moc.save()
            dismiss()
        }
    }
    
    func saveNewActivity() {
        let act = ActivityObject(context: moc)
        act.id = UUID()
        act.name = name
        act.location = location
        act.date = date
        act.price = Double(price) ?? 0.0
        act.time = duration
        act.link = link
        trip.addToActivities(act)
        try? moc.save()
        dismiss()
    }
}

struct ActivityListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ActivityListView(trip: createTrip())
                .environment(\.managedObjectContext, DataController.preview.container.viewContext)
        }
    }
    
    static func createActivity() -> ActivityObject {
        let controller = DataController.preview.container.viewContext
        let activity = ActivityObject(context: controller)
        activity.id = UUID()
        activity.name = "Aire"
        activity.location = "New York"
        activity.price = 52.00
        activity.time = "5 hours"
        activity.link = "google.com"
        activity.date = "5/22"
        return activity
    }
    
    static func createActivities(num: Int) -> NSSet {
        let controller = DataController.preview.container.viewContext
        var activities: [ActivityObject] = []
        for _ in 1...num {
            let activity = ActivityObject(context: controller)
            activity.id = UUID()
            activity.name = "Aire"
            activity.location = "NYC"
            activity.price = 700
            activity.time = "7PM"
            activities.append(activity)
        }
        return NSSet(array: activities)
    }
    
    static func createTrip() -> TripObject {
        let controller = DataController.preview.container.viewContext
        let trip = TripObject(context: controller)
        trip.name = "NEW YORK"
        trip.location = "New York"
        trip.startDate = "5/22"
        trip.budget = 800
        trip.endDate = "5/22"
        trip.notes = "What is Lorem Ipsum? Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged."
        trip.activities = createActivities(num: 7)
        return trip
    }
}
