//
//  FireDBHelper.swift
//  SaveThisSpot
//
// Group 8
// Zubear Nassimi id# 991 628 529
// Shehnazdeep Kaur id# 991 539 256
//

import Foundation
import FirebaseFirestore
import WidgetKit

class FireDBHelper : ObservableObject{
    
    @Published var spotList = [Spot]()
    
    private static var shared : FireDBHelper?
    private var db : Firestore
    
    // Users ----> Spots
    private let COLLECTION_SPOTS = "spots"
    private let COLLECTION_USERS = "users"
    private let ATTRIBUTE_LONGITUDE = "longitude"
    private let ATTRIBUTE_LATITUDE = "latitude"
    private let ATTRIBUTE_LABEL = "label"
    
    private init(database : Firestore){
        self.db = database
    }//init
    
    static func getInstance() -> FireDBHelper{
        
        if(self.shared == nil){
            self.shared = FireDBHelper(database: Firestore.firestore())
        }
        
        return self.shared!
    }//getInstance function
    
    func insertSpot(spot: Spot) {
        let loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? "NA"
        
        if (loggedInUserEmail != "NA") {
            do {
                try self.db.collection(self.COLLECTION_USERS)
                    .document(loggedInUserEmail)
                    .collection(self.COLLECTION_SPOTS)
                    .addDocument(from: spot) { error in
                        if error == nil {
                            // Only update UserDefaults if Firebase save is successful
                            let sharedDefaults = UserDefaults(suiteName: "group.UserDefaultsSavedLocation")
                            sharedDefaults?.set(spot.label, forKey: "lastLocationLabel")
                            sharedDefaults?.set(spot.description, forKey: "lastLocationDescription")
                            
                            //reload all timelines for the widgets
                            WidgetCenter.shared.reloadAllTimelines()
                        }
                    }
            } catch let error {
                print("Error adding document: \(error)")
            }
        } else {
            print(#function, "Unable to create spot. You must login first")
        }
    }

    func updateSpot(spotId: String, newLabel: String, newDescription: String) {
            let loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? "NA"

            guard loggedInUserEmail != "NA" else {
                print(#function, "Unable to update spot. You must login first")
                return
            }

            let spotDocument = self.db.collection(COLLECTION_USERS)
                                      .document(loggedInUserEmail)
                                      .collection(COLLECTION_SPOTS)
                                      .document(spotId)

            let updatedData: [String: Any] = [
                "label": newLabel,
                "description": newDescription
            ]

            spotDocument.updateData(updatedData) { error in
                if let err = error {
                    print(#function, "Unable to update spot due to error: \(err)")
                } else {
                    print(#function, "Spot successfully updated")
                    // Post-update logic (like updating UI) can be added here
                }
            }
        }
    
    func retrieveAllSpots(){
        let loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? "NA"

        do{
            self.db
                .collection(COLLECTION_USERS)
                .document(loggedInUserEmail)
                .collection(self.COLLECTION_SPOTS).addSnapshotListener( { (querySnapshot, error) in
                guard let result = querySnapshot else{
                    print(#function, "No snapshot obtained due to error : \(error)")
                    return
                }//else
                print(#function, "result querySnapshot : \(result)")
                
                //search the spotList before getting all the data again
                
                result.documentChanges.forEach{ (docChange) in
                    do{
                        //Obtain the Spot object from document
                        let spot = try docChange.document.data(as: Spot.self)
                        
                        print(#function, "Spot retrieved : id : \(spot.id), longitude: \(spot.longitude), latitude: \(spot.latitude)")
                        
                        //check if the document that has changed exists in the curent list of spots
                        let matchedIndex = self.spotList.firstIndex(where: { ( $0.id?.elementsEqual(docChange.document.documentID))! })
                        
                        if docChange.type == .added{
                            print(#function, "New document is added : \(spot.longitude), \(spot.latitude)")
                            //if the object is still in the list
                            if (matchedIndex != nil){
                                //the object is already in the list
                                //do nothing
                            }else{
                                self.spotList.append(spot)
                            }
                        }
                        
                        if docChange.type == .modified{
                            if (matchedIndex != nil){
                                print(#function, "New document is updated : \(spot.longitude), \(spot.latitude)")
                            }
                        }
                        
                        if docChange.type == .removed{
                            if (matchedIndex != nil){
                                print(#function, "New document is removed : \(spot.longitude), \(spot.latitude)")
                            }
                        }
                        
                    }catch let err as NSError{
                        print(#function, "No snapshot obtained due to error : \(error)")
                    }//catch
                }//forEach
            })//snapShotListener
            
        }catch let err as NSError{
            print(#function, "Unable to retrieve due to error : \(err)")
        }//catch
    }//retrieveAllMovies function
    
    func deleteSpot(indexToDelete : Int){
        let loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? "NA"


        let documentID = self.spotList[indexToDelete].id!

        self.db
            .collection(COLLECTION_USERS)
            .document(loggedInUserEmail)
            .collection(self.COLLECTION_SPOTS)
            .document(documentID)
            .delete{ error in
                if let err = error{
                    print(#function, "Unable to delete due to error : \(err)")
                }else{
                    print(#function, "Document deleted successfully")
                } //ifElse
            } //delete
    }// deleteSpot function
        
    
    
    
    
    func searchSpotByLabel(searchText : String){
        let loggedInUserEmail = UserDefaults.standard.string(forKey: "KEY_EMAIL") ?? "NA"

        do{
            self.db
                .collection(COLLECTION_USERS)
                .document(loggedInUserEmail)
                .collection(self.COLLECTION_SPOTS)
                .whereField(ATTRIBUTE_LABEL, isEqualTo: searchText)
                .order(by: ATTRIBUTE_LABEL, descending: true)

                .addSnapshotListener( { (querySnapshot, error) in
                guard let result = querySnapshot else{
                    print(#function, "No snapshot obtained due to error : \(error)")
                    return
                }//else

                print(#function, "result querySnapshot : \(result)")

                result.documentChanges.forEach{ (docChange) in
                    do{
                        //Obtain the Movie object from document
                        let spot = try docChange.document.data(as: Spot.self)

                        print(#function, "Spot retrieved : id : \(spot.id)")

                        if docChange.type == .added{
                            print(#function, "New document is added : \(spot.id)")
                            self.spotList.append(spot)
                        }

                        if docChange.type == .modified{
                            print(#function, "New document is updated : \(spot.id)")

                        }

                        if docChange.type == .removed{
                            print(#function, "New document is removed : \(spot.id)")

                        }

                    }catch let err as NSError{
                        print(#function, "No snapshot obtained due to error : \(error)")
                    }//catch
                }//forEach
            })//snapShotListener

        }catch let err as NSError{
            print(#function, "Unable to retrieve due to error : \(err)")
        }//catch
    }//search movie by name function
    
    
}//class
