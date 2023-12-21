//FavoriteSpotView

//
//  FavouriteSpotsView.swift
//  SaveThisSpot
//
// Group 8
// Zubear Nassimi id# 991 628 529
// Shehnazdeep Kaur id# 991 539 256
//

import SwiftUI
import FirebaseAuth

struct FavouriteSpotsView: View {
    
    @Binding var rootView : RootView
    
    @EnvironmentObject var dbHelper : FireDBHelper
    
    @State private var searchText : String = ""
    
    var body: some View {
            VStack{
                List{
                    ForEach(self.dbHelper.spotList.enumerated().map({$0}), id : \.element.self){ index, spot in
                        
                        NavigationLink{
                            MyFavouriteSpotView(spot: spot, rootView: self.$rootView).environmentObject(self.dbHelper)
                        }label: {
                            
                            HStack{
                                
                                if(spot.label == "NA"){
                                    Text(spot.address)
                                }
                                else{
                                    Text(spot.label)
                                }
                                
                                Image(systemName: "heart")
                                    .bold()
                            }//HStack
                        }//NavigationLink
                    }//ForEach
                    .onDelete(perform: { indexSet in

                        for index in indexSet{
                            //perform the change in DB
                            self.dbHelper.deleteSpot(indexToDelete : index)
                        }
                    })
                }//List

            }//VStack
            .searchable(text: self.$searchText, prompt: "Search by spot by label")
            .onChange(of: self.searchText){ _ in
                
                print(#function, "searchText : \(self.searchText)")
                
                self.dbHelper.spotList.removeAll()
                
                if (self.searchText.isEmpty){
                    self.dbHelper.retrieveAllSpots()
                }else{
                        //reset the spotList to show only the result from search operation
                    self.dbHelper.searchSpotByLabel(searchText: self.searchText)
                }
            }
            .onAppear{
                self.dbHelper.spotList.removeAll()
                self.dbHelper.retrieveAllSpots()
            }
        
    } //body
}//struct

//#Preview {
//    FavouriteSpotsView()
//}

