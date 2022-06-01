//
//  ContentView.swift
//  A&R Trip Planner
//
//  Created by Robin Lopez Ordonez on 2/4/22.
//
// Gift for aeon and I's anniversary on 2/22/22 

import SwiftUI

struct OpeningView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.aeonPink
                    .ignoresSafeArea()
                
                VStack {
                    ZStack {
                        Color.robinPink
                        VStack {
                            Text("Aeon and Robin's")
                                .font(.title)
                                .kerning(4)
                            Text("Trip Planning App")
                                .font(.title)
                                .kerning(4)
                            Text("✈️✈️ 🚞🚞 🏖🏖")
                                .padding(.top, 5)
                        }
                    }
                    .frame(width: 330, height: 150, alignment: .center)
                    .cornerRadius(30)
                    
                    Image("IMG_2655")
                        .resizable()
                        .scaledToFit()
                        .cornerRadius(30)
                        .padding(30)
                
                    HStack {
                        ZStack {
                            Color.robinPink
                            Text("made with love for Aeon")
                                .font(.footnote)
                        }
                        .frame(width: 180, height: 40, alignment: .center)
                        .cornerRadius(30)
                        .padding(.trailing, 40)
                        
                        NavigationLink(destination: MainTripsView(), label: {
                            HStack {
                                Text("click to enter")
                                    .font(.body)
                                Image(systemName: "arrow.right")
                                    .resizable()
                                    .frame(width: 30, height: 30, alignment: .center)
                            }
                        })
                            .foregroundColor(.black)
                    }
                }
            }
            .navigationBarHidden(true)
        }
        .accentColor(Color.lightPurple)
    }
}

struct OpeningView_Previews: PreviewProvider {
    static var previews: some View {
        OpeningView()
    }
}
