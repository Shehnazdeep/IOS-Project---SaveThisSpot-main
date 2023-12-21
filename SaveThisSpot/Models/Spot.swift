// Group 8
// Zubear Nassimi id# 991 628 529
// Shehnazdeep Kaur id# 991 539 256

import Foundation
import FirebaseFirestoreSwift

struct Spot : Identifiable, Hashable, Codable{
    
    @DocumentID var id : String? = UUID().uuidString
    
    var longitude : String
    var latitude : String
    var label: String
    var description: String
    var address: String
    
    init(){
        self.longitude = "NA"
        self.latitude = "NA"
        self.label = "NA"
        self.description = "NA"
        self.address = "NA"
    }
    
    init(longitude: String, latitude: String){
        self.longitude = longitude
        self.latitude = latitude
        self.label = "NA"
        self.description = "NA"
        self.address = "NA"
        
    }
    init(longitude: String, latitude: String, label: String, description: String){
        self.longitude = longitude
        self.latitude = latitude
        self.label = label
        self.description = description
        self.address = "NA"
    }
}
