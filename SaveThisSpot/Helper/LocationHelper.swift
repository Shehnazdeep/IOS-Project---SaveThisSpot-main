//
//  LocationHelper.swift
//  SaveThisSpot
//
//  Created by Shehnazdeep Kaur on 2023-11-22.
//

import Foundation
import CoreLocation

class LocationHelper: NSObject, ObservableObject, CLLocationManagerDelegate  {
    
    
    @Published var currentLocation : CLLocation?
    
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    override init(){
        super.init() // calls the NSObject class initializer
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        self.locationManager.delegate = self
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        switch manager.authorizationStatus{
        case .authorizedAlways:
            print(#function, "location access is granted always")
            
            manager.startUpdatingLocation()
            
        case .authorizedWhenInUse:
            print(#function, "location is granted when in use")
                //to trigger didUPdateLocation() callback to start receiving location changes
            
            manager.startUpdatingLocation()
            
        case .notDetermined, .denied:
                //request the location permission if needed or restrict the functionalities dependendent on locaiton
            print(#function, "user not responded to request or denied")
            
                //request the appropriate permission
            manager.requestWhenInUseAuthorization()
            
                //stop recieving location changes if any is running
            manager.stopUpdatingLocation()
            
        case .restricted:
                //request the full access to the location if needed or continue with restricted access
            print(#function, "location access is restricted")
            
                //request the appropriate permission
            manager.requestWhenInUseAuthorization()
            manager.requestAlwaysAuthorization()
        @unknown default:
                //terminate the app if can't proceed without the location related functionality or request the permission
            print(#function, "Location access is ot availaible")
        }
    }
    

    
    
        //to recieve the changes in location
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if(locations.isEmpty){
            print(#function, "App is unable to retrieve location.")
        } else{
                //app has access to the location
            
                //access the most recent location
            if (locations.last != nil){
                
                print(#function, "locations.last : \(locations.last)")
                self.currentLocation = locations.last
            }else{
                    //access the oldest location or previously known location
                
                self.currentLocation = locations.first
            }
        }
        
        print(#function, "location has updated")
        print(#function, "current location: \(self.currentLocation)")
        
    }
    
    
    
}
