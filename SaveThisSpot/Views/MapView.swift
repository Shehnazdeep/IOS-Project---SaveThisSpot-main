//
//  MapView.swift
//  SaveThisSpot
//
// Group 8
// Zubear Nassimi id# 991 628 529
// Shehnazdeep Kaur id# 991 539 256
//

import SwiftUI

struct MapView: View {
    
    @Binding var rootView : RootView
    @EnvironmentObject var locationHelper: LocationHelper

    var body: some View {
        VStack {
            if self.locationHelper.currentLocation != nil {
                // Show the map with location
                MyMap().environmentObject(self.locationHelper)
                
            } else {
                Text("Current location not available")
            }
        }
    }
}
