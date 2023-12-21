//  MyFavouriteSpotView.swift
//  SaveThisSpot
//
// Group 8
// Zubear Nassimi id# 991 628 529
// Shehnazdeep Kaur id# 991 539 256
//

import SwiftUI
import FirebaseAuth

struct MyFavouriteSpotView: View {
    
    var spot: Spot
    
    @Binding var rootView : RootView
    
    @EnvironmentObject var dbHelper : FireDBHelper
    
    var body: some View {
            VStack {
                Spacer()
                
                MapView(rootView: self.$rootView).environmentObject(self.dbHelper)
                Spacer()
                Text(spot.address)
                Text(spot.label).padding(.top, 5)
                Text(spot.description).padding(.top, 5)

                NavigationLink(destination: UpdateSpotView(spot: spot).environmentObject(dbHelper)) {
                    Text("Update")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                Spacer()
            }
        }}













