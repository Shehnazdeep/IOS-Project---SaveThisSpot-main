
//SaveCurrentSpotView

//
//  SaveCurrentSpotView.swift
//  SaveThisSpot
//
// Group 8
// Zubear Nassimi id# 991 628 529
// Shehnazdeep Kaur id# 991 539 256
//

import SwiftUI
import Firebase

struct SaveCurrentSpotView: View {
    @EnvironmentObject var dbHelper: FireDBHelper
    @EnvironmentObject var locationHelper: LocationHelper
    @Binding var rootView: RootView
    @State private var result: String = ""
    @State private var description: String = ""
    @State private var showAlert = false
    @State private var label: String = ""
    
    var body: some View {
        VStack {

            MyMap().environmentObject(self.locationHelper)
                .frame(height: UIScreen.main.bounds.height / 3)
            HStack {
                Spacer()
                TextField("Enter Label", text: $label)
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                Spacer()
            }
            HStack {
                Spacer()
                TextField("Enter Description...", text: $description)
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
                Spacer()
            }
            
            Button(action: {
                self.saveCurrentLocation()
            }) {
                
                HStack{
                    Text("Save Spot")
                }
                .padding()
                .foregroundColor(.white)
            }
            .background(Color.blue) // Use a contrasting color for the button
            .cornerRadius(20)
        }
        .padding() // Add padding to the entire VStack
    }
    
    private func saveCurrentLocation() {
        print("Saving current location")
        
        guard let currentLocation = self.locationHelper.currentLocation else {
            self.result = "Location not available"
            return
        }
        
        self.locationHelper.performReverseGeocoding(location: currentLocation, completionHandler: { (result, error) in
            if let error = error {
                print("Reverse geocoding error:", error.localizedDescription)
                self.result = "Address not available"
            } else {
                self.result = result ?? "NA"
                
                var newSpot = Spot()
                
                if self.description.isEmpty && self.label.isEmpty {
                    newSpot.latitude = "\(currentLocation.coordinate.latitude)"
                    newSpot.longitude = "\(currentLocation.coordinate.longitude)"
                    newSpot.address = self.result
                    
                } else if self.description.isEmpty {
                    newSpot.latitude = "\(currentLocation.coordinate.latitude)"
                    newSpot.longitude = "\(currentLocation.coordinate.longitude)"
                    newSpot.label = self.label
                    newSpot.address = self.result
                    
                } else if self.label.isEmpty {
                    newSpot.latitude = "\(currentLocation.coordinate.latitude)"
                    newSpot.longitude = "\(currentLocation.coordinate.longitude)"
                    newSpot.description = self.description
                    newSpot.address = self.result
                    
                } else {
                    newSpot.latitude = "\(currentLocation.coordinate.latitude)"
                    newSpot.longitude = "\(currentLocation.coordinate.longitude)"
                    newSpot.label = self.label
                    newSpot.description = self.description
                    newSpot.address = self.result
                }
                
                self.dbHelper.insertSpot(spot: newSpot)
                self.description = ""
                self.label = ""
            }
        })
    }
}
