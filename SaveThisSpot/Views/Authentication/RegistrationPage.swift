//
//  RegistrationPage.swift
//  SaveThisSpot
//
//  Created by Shehnazdeep Kaur on 2023-11-15.
//

import SwiftUI

struct RegistrationPage: View {
    
    @State private var email = ""
    @State private var fullname = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    
    
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
                
            }//hstack
            .padding(.vertical,32)
            
            VStack(alignment: .leading, spacing: 12){
                
                Section{
                    
                    Text("Email Address: ")
                        .foregroundColor(Color(.darkGray))
                        .fontWeight(.semibold)
                        .font(.footnote)
                        .font(.system(size: 14))
                    
                    TextField("Enter your email", text: $email)
                        .font(.system(size: 14))
                        .autocapitalization(.none)
                }//section
                Divider()
                
                Section{
                    Text("Name: ")
                        .foregroundColor(Color(.darkGray))
                        .fontWeight(.semibold)
                        .font(.footnote)
                        .font(.system(size: 14))
                    
                    TextField("Enter your name", text: $fullname)
                        .font(.system(size: 14))
                    
                }//section
                Divider()
                
                Section{
                    Text("Password: ")
                        .foregroundColor(Color(.darkGray))
                        .fontWeight(.semibold)
                        .font(.footnote)
                        .font(.system(size: 14))
                    
                    TextField("Enter your password", text: $password)
                        .font(.system(size: 14))
                    
                }//section
                Divider()
                
                Section{
                    Text("Confirm Password: ")
                        .foregroundColor(Color(.darkGray))
                        .fontWeight(.semibold)
                        .font(.footnote)
                        .font(.system(size: 14))
                    
                    TextField("Confirm your password", text: $password)
                        .font(.system(size: 14))
                    
                }//section
                Divider()
            }//vstack
            .padding(.horizontal)
            .padding(.top,50)
            
            Button(action: {
                    //behavior/operation
                
                
            }){
                    //appearance
                HStack{
                    Text("SIGN UP")
                        .font(.title2)
                   
                }
                .frame(width: UIScreen.main.bounds.width-32, height: 30)
                
            }
            .tint(.blue)
            .buttonStyle(.borderedProminent)
            .cornerRadius(10)
            .padding(.top, 24)
            
            
            Spacer()
            
        }//Vstack
    }//body
}//struct

#Preview {
    RegistrationPage()
}
