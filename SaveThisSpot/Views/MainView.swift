//
//  HomeView.swift
//  SaveThisSpot
//
// Group 8
// Zubear Nassimi id# 991 628 529
// Shehnazdeep Kaur id# 991 539 256
//

import SwiftUI
import FirebaseAuth

struct MainView: View {
    
    @Binding var rootView : RootView
    
    @EnvironmentObject var dbHelper : FireDBHelper
    @EnvironmentObject var locationHelper: LocationHelper
    
    var body: some View {
        
        VStack{
            HStack{
                Text("SaveThisSpot")
                    .fontDesign(.serif)
                    .font(.system(size: 34))
                    .italic()
                    //.fontWeight(.bold)
                Image(systemName: "heart.circle")
                
                    .foregroundColor(.red)
                    .font(.system(size: 38))
            }
        .padding(.vertical,32)
            
            TabView{
                SaveCurrentSpotView(rootView: self.$rootView).tabItem{
                    Image(systemName: "pin.square")
                    Text("Save location")
                }
                
                
                FavouriteSpotsView(rootView: self.$rootView).tabItem{
                    Image(systemName: "heart")
                    Text("Favourites")
                }
            }//TabView
        }//vstack
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                Button{
                 self.logout()
                  
                }label: {
                    Image(systemName: "arrow.right.square")
                }
            }//ToolbarItem
        }
    }//body
    
    private func logout(){
        do{
            try Auth.auth().signOut()
            
            self.rootView = .login
        }catch let err as NSError{
            print(#function, "Unable to sign out : \(err)")
        }
    }
    
}//struct
