//
//  Styling.swift
//  A&R Trip Planner
//
//  Created by Robin Lopez Ordonez on 2/4/22.
//

import Foundation
import SwiftUI

extension Color {
    static let aeonPink = Color(red: 250/255, green: 218/255, blue: 221/255)
    static let robinPink = Color(red: 255/255, green: 191/255, blue: 201/255)
    static let lightPurple = Color(red: 121/255, green: 92/255, blue: 142/255)
}

struct TwoImageLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.icon
            configuration.title
            configuration.icon
        }
    }
}

struct ImageAfterLabelStyle: LabelStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.title
            configuration.icon
        }
    }
}
