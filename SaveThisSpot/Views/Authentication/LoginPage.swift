//
//  LoginPage.swift
//  SaveThisSpot
//
//  Created by Shehnazdeep Kaur on 2023-11-15.
//

import SwiftUI

struct LoginPage: View {
    
    @State private var enterEmail = ""
    @State private var enterPass  = ""
    @State private var showingAlert = false
    @State private var errorMessage : String = ""
    
    
    var body: some View {
        
       
        
//        let email: String = "name@example.com"
//        let pass: String = "Enter your Password"
        NavigationStack{
            
            VStack(){
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
                
               // Spacer()
                
                VStack(alignment: .leading, spacing: 12){
                    
                    Section(){
                        Text("Email Address: ")
                            .foregroundColor(Color(.darkGray))
                            .fontWeight(.semibold)
                            .font(.footnote)
                            .font(.system(size: 14))
                        
                        TextField("Enter your email", text: $enterEmail)
                            .font(.system(size: 14))
                            .autocapitalization(.none)
                           
                    }
                    Divider()
                  
                    
                    Section{
                        Text("Password: ")
                            .foregroundColor(Color(.darkGray))
                            .fontWeight(.semibold)
                            .font(.footnote)
                            .font(.system(size: 14))
                        
                        TextField("Enter your password", text: $enterPass)
                            .font(.system(size: 14))
                            
                    }
                    Divider()
                    
                   
                }//vstack
                .padding(.horizontal)
                .padding(.top,80)
              
                Button(action: {
                        //behavior/operation
                    self.displayError()
                  
                }){
                        //appearance
                    HStack{
                        Text("SIGN IN")
                            .font(.title2)
                        Image(systemName: "arrow.right")
                    }
                    .frame(width: UIScreen.main.bounds.width-32, height: 30)
                    
                }
                .tint(.blue)
                .buttonStyle(.borderedProminent)
                .cornerRadius(10)
                .padding(.top, 24)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Error"), message: Text("\(self.errorMessage)"),dismissButton: .default(Text("Got it!"))
                    )
                    
                }
                
                
                Spacer()
                
                
                //Sign-Up Button
                
             //   Navigation Link to Sign-Up Page
                NavigationLink{
                RegistrationPage()
                }label:{
                    HStack(spacing: 3){
                        
                        Text("Doesn't have an account?")
                        Text("Sign Up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                    
                }
                
            }//Vstack
            
            
        }//NavigationStack
    }//body
    
    private func displayError(){
        
        
        if(self.enterEmail.isEmpty || self.enterPass.isEmpty ){
            self.errorMessage = "Please fill all the fields!!"
            self.showingAlert = true
        }
      
        
        
    }
    
}//struct

#Preview {
    LoginPage()
}
