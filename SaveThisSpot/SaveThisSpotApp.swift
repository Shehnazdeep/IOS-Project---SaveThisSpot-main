//
//  SaveThisSpotApp.swift
//  SaveThisSpot
//
// Group 8
// Zubear Nassimi id# 991 628 529
// Shehnazdeep Kaur id# 991 539 256
//

import SwiftUI
import Firebase
import FirebaseFirestore

@main
struct SaveThisSpotApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    let locationHelper = LocationHelper()

    
    var body: some Scene {
        WindowGroup {
            LaunchView().environmentObject(LocationHelper())
        }
    }
}
