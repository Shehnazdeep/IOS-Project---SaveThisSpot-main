


//UpdateSpotView

//
//  UpdateSpotView.swift
//  SaveThisSpot
//
// Group 8
// Zubear Nassimi id# 991 628 529
// Shehnazdeep Kaur id# 991 539 256
//

import SwiftUI

struct UpdateSpotView: View {
    @EnvironmentObject var dbHelper: FireDBHelper
    @State private var label: String
    @State private var description: String

    var spot: Spot

    init(spot: Spot) {
        self.spot = spot
        _label = State(initialValue: spot.label ?? "")
        _description = State(initialValue: spot.description ?? "")
    }

    var body: some View {
        VStack {
            TextField("Label", text: $label)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            TextField("Description", text: $description)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Update Spot") {
                dbHelper.updateSpot(spotId: spot.id!, newLabel: label, newDescription: description)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
    }
}
