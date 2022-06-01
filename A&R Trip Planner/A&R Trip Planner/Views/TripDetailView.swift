//
//  TripDetailView.swift
//  A&R Trip Planner
//
//  Created by Robin Lopez Ordonez on 2/19/22.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct TripDetailView: View {
    var trip: TripObject
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    @State var didChange: Bool = false
    @State var expenses: Double = 0.0
    @State private var newName: String = ""
    @State private var newLocation: String = ""
    @State private var newStartDate: String = ""
    @State private var newEndDate: String = ""
    @State private var newBudget: String = ""
    @State private var showingAlert = false
    
    let context = CIContext()
    let filter = CIFilter.qrCodeGenerator()
    
    init(trip: TripObject) {
        self.trip = trip
        let coloredAppearance = UINavigationBarAppearance()
        coloredAppearance.backgroundColor = UIColor(Color.aeonPink)
        coloredAppearance.shadowColor = .clear

        UINavigationBar.appearance().standardAppearance = coloredAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.aeonPink
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    AttributeView(title: "Name", value: "\(trip.name ?? "")", newValue: $newName) {
                        trip.name = newName
                        try? moc.save()
                        dismiss()
                    }
                    AttributeView(title: "Location", value: "\(trip.location ?? "")", newValue: $newLocation) {
                        trip.location = newLocation
                        try? moc.save()
                        dismiss()
                    }
                    AttributeView(title: "Start Date", value: "\(trip.startDate ?? "No Start Date Given")", newValue: $newStartDate ) {
                        trip.startDate = newStartDate
                        try? moc.save()
                        dismiss()
                    }
                    AttributeView(title: "End Date", value: "\(trip.endDate ?? "No End Date Given")", newValue: $newEndDate) {
                        trip.endDate = newEndDate
                        try? moc.save()
                        dismiss()
                    }
                    
                    NavigationLink(destination: ActivityListView(trip: trip).environment(\.managedObjectContext, moc), label: {
                        SimpleButtonAttributeView(title: "Activities", value: "\(trip.activities?.count ?? 0)")
                    })
                        .foregroundColor(.black)
                    
                    SimpleAttributeView(title: "Expected Expenses", value: "\(calculateExpenses())")
                    AttributeView(title: "Budget", value: "\(trip.budget)", newValue: $newBudget, keyBoardType: .numberPad) {
                        if Double(newBudget) != 0 {
                            trip.budget = Double(newBudget)!
                        }
                        try? moc.save()
                        dismiss()
                    }
                    SimpleAttributeView(title: "Notes", value: "\(trip.notes ?? "")")
                    
                    HStack {
                        Spacer()
                        Label("Share This Trip", systemImage: "square.and.arrow.up")
                            .frame(width: 200, height: 50, alignment: .center)
                            .foregroundColor(.black)
                            .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.black, lineWidth: 1)
                                )
                            .onTapGesture {
                                showingAlert = true
                            }
                        Spacer()
                    }
                }
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        }
        .navigationBarHidden(false)
        .navigationTitle(trip.name ?? "Trip")
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    hideKeyboard()
                }
            }
        }
        .accentColor(Color.lightPurple)
        .alert("Coming Soon! \n also, i love you so much, i hope youre enjoying our anniversary. \n 2/22 best date ever <3", isPresented: $showingAlert) {
                    Button("OK", role: .cancel) { }
        }
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        filter.message = Data(string.utf8)

        if let outputImage = filter.outputImage {
            if let cgimg = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgimg)
            }
        }

        return nil
    }
    
    func calculateExpenses() -> Double {
        guard let activities = trip.activities else { return 0 }
        var exp = 0.0
        for activity in activities {
            let act = activity as! ActivityObject
            exp += act.price
        }
        return exp
    }
}

struct AttributeView: View {
    var title: String
    var value: String
    @Binding var newValue: String
    var keyBoardType: UIKeyboardType = .default
    var completion: () -> ()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                HStack {
                    Text("\(title):")
                    Text("\(value)")
                        .font(.headline)
                        .foregroundColor(Color.blue)
                }
                TextField("Edit \(title)", text: $newValue)
                    .keyboardType(keyBoardType)
            }
            Spacer()
            Button("Save Edit", action: {
                completion()
            })
                .padding(5)
                .foregroundColor(Color.teal)
                .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.teal, lineWidth: 2)
                    )
                .padding(.leading)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding()
        .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1)
            )
    }
}

struct SimpleAttributeView: View {
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(title):")
                Text("\(value)")
                    .font(.subheadline)
            }
            Spacer()
            Button("", action: {})
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding()
        .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1)
            )
    }
}

struct SimpleButtonAttributeView: View {
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("\(title):")
                Text("\(value)")
                    .font(.subheadline)
            }
            Spacer()
            Label("See Activities", systemImage: "arrow.right")
                .foregroundColor(.teal)
                .labelStyle(ImageAfterLabelStyle())
                
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .leading)
        .padding()
        .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black, lineWidth: 1)
            )
    }
}


struct TripDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TripDetailView(trip: createTrip())
                .environment(\.managedObjectContext, DataController.preview.container.viewContext)
        }
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
        trip.activities = createActivities(num: 2)
        return trip
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
}
