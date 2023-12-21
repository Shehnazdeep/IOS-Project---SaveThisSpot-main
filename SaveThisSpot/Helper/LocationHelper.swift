//
//  LocationHelper.swift
//  SaveThisSpot
//
// Group 8
// Zubear Nassimi id# 991 628 529
// Shehnazdeep Kaur id# 991 539 256
//

import Foundation
import CoreLocation

class LocationHelper : NSObject, ObservableObject, CLLocationManagerDelegate{
    
    @Published var currentLocation : CLLocation?
    
    private let locationManager = CLLocationManager()
    private let geocoder = CLGeocoder()
    
    override init(){
        super.init()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
        
        self.locationManager.delegate = self
    }//init
        
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        switch manager.authorizationStatus{
        case .authorizedAlways:
            //allow access to functionalities which uses location in foreground and background
            print(#function, "location access is granted always")
            manager.startUpdatingLocation()
            
        case .authorizedWhenInUse:
            //allow access to functionalities which uses location in foreground
            print(#function, "location access is granted when in use")
            manager.startUpdatingLocation()
            
        case .notDetermined, .denied:
            //request the location permission if needed or restrict the functionalities which are depended on location
            print(#function, "user did not respond to location request")
            //request for permission
            manager.requestWhenInUseAuthorization()
            //stop receiving location changes if any is runnin
            manager.stopUpdatingLocation()
            
        case .restricted:
            //request full access to location if needed or continue with restricted access
            print(#function, "location access is restricted")
            //request for permission
            manager.requestWhenInUseAuthorization()
            manager.requestAlwaysAuthorization()
            manager.stopUpdatingLocation()
            
        @unknown default:
            //terminate the app if can't
            print(#function, "location access is not available")
        }//switch
    }//func
    
    //to receive changes in the location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if (locations.isEmpty){
            print(#function, "App is unable to retrieve location")
        }else{
            //app has access to location
            //access the most recent location
            if (locations.last != nil){
                print(#function, "locations.last : \(locations.last)")
                self.currentLocation = locations.last
            }else{
                //access oldest location or previously know location
                self.currentLocation = locations.first
            }
        }
        
        print(#function, "location change updated")
        print(#function, "current location: \(self.currentLocation)")
    } //func
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(#function, "Location access failed due to error : \(error)")
    }//func
    
    func performReverseGeocoding(location : CLLocation, completionHandler: @escaping(String?, NSError?) -> Void){
        //obtain address using coordinates
        
        //asynchronous background task
        self.geocoder.reverseGeocodeLocation(location, completionHandler: {
            (placemarkList, error) in
            if (error != nil){
                print(#function, "Reverse geocoding not successfully complete due to error : \(error)")
                //task is completed; returning the flow of execution tothe calling block
                completionHandler(nil, error as? NSError)
            }else{
                if let firstAddress = placemarkList?.first {
                    let addressComponents: [String?] = [
                        firstAddress.subThoroughfare,
                        firstAddress.subLocality,
                        firstAddress.thoroughfare,
                        firstAddress.locality,
                        firstAddress.postalCode,
                        firstAddress.administrativeArea,
                        firstAddress.country
                    ]
                    
                    let result = addressComponents.compactMap { $0 }.joined(separator: ", ")
                    
                    completionHandler(result, nil)
                } else {
                    print(#function, "No address found for given coordinates")
                    completionHandler(nil, NSError(domain: "com.example.ReverseGeocoding", code: 1, userInfo: nil))
                }
            }//if-else
        })//reverGeocodeLocation
    }//func
}//class
