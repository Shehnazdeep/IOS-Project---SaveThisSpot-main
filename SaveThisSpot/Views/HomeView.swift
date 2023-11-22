//
//  HomeView.swift
//  SaveThisSpot
//
//  Created by Shehnazdeep Kaur on 2023-11-15.
//

import SwiftUI

struct HomeView: View {
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
                SaveCurrentSpotView().tabItem{
                    Image(systemName: "pin.square")
                    Text("Save location")
                }
                
                SaveRemoteSpotView().tabItem{
                    Image(systemName: "plus.app")
                    Text("Add location")
                }
                
                FavouriteSpotsView().tabItem{
                    Image(systemName: "heart")
                    Text("Favourites")
                }
            }//TabView
            
        }//vstack
        .toolbar{
            ToolbarItem(placement: .navigationBarTrailing){
                
                NavigationLink(){
                    
                   
                    
                    
                }label:{
                    Image(systemName: "arrowshape.turn.up.right.circle.fill")
                     
                    
                }
                .foregroundColor(.brown)
               
                
            }
        }
       
    }//body
}//struct

#Preview {
    HomeView()
}
