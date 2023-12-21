//
//  MyMap.swift
//  SaveThisSpot
//
// Group 8
// Zubear Nassimi id# 991 628 529
// Shehnazdeep Kaur id# 991 539 256
//

import Foundation
import MapKit
import SwiftUI

struct MyMap : UIViewRepresentable{
    
    //indicate the type of view our struct wants to represent
    typealias UIViewType = MKMapView
    
    @EnvironmentObject var locationHelper : LocationHelper
    
    //specifies the initial state of the view to be represented
    func makeUIView(context: Context) -> MKMapView {
        let sourcesCoordinates : CLLocationCoordinate2D
        
        if (self.locationHelper.currentLocation != nil){
            sourcesCoordinates = self.locationHelper.currentLocation!.coordinate
        }else{
            sourcesCoordinates = CLLocationCoordinate2D(latitude: 43.8940, longitude: -79.3746)
        }//if-else
        
        let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
        let region = MKCoordinateRegion(center: sourcesCoordinates, span: span)
        
        let map = MKMapView()
        map.setRegion(region, animated: true)
        map.showsUserLocation = true
        map.isScrollEnabled = true
        map.isZoomEnabled = true
        
        return map
    }//func
    
    //specifies how to update the existing view with new informaton received
    func updateUIView(_ uiView: MKMapView, context: Context) {
        
        let sourcesCoordinates : CLLocationCoordinate2D
        
        if (self.locationHelper.currentLocation != nil){
            sourcesCoordinates = self.locationHelper.currentLocation!.coordinate
        }else{
            sourcesCoordinates = CLLocationCoordinate2D(latitude: 43.8940, longitude: -79.3746)
        }//if-else
        
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: sourcesCoordinates, span: span)
        
        uiView.setRegion(region, animated: true)
        
        //show the pin on map
        let mapAnnotation = MKPointAnnotation()
        mapAnnotation.coordinate = sourcesCoordinates
        mapAnnotation.title = "You are here !"
        
        //attach the pin to map
        uiView.addAnnotation(mapAnnotation)
    }//func
}//struct
