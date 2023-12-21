//
//  SignUpView.swift
//  SaveThisSpot
//
// Group 8
// Zubear Nassimi id# 991 628 529
// Shehnazdeep Kaur id# 991 539 256
//

import SwiftUI
import FirebaseAuth

struct SignUpView: View {
    
    @Binding var rootView : RootView
    
    @State private var email : String = "user1@gmail.com"
    @State private var password : String = "pass1234"
    
    var body: some View {
        VStack{
            HStack{
                Text("SaveThisSpot")
                    .fontDesign(.serif)
                    .font(.system(size: 34))
                    .italic()
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
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                        .font(.system(size: 14))
                        .autocapitalization(.none)
                }//section
                Divider()
                
                Section{
                    Text("Password: ")
                        .foregroundColor(Color(.darkGray))
                        .fontWeight(.semibold)
                        .font(.footnote)
                        .font(.system(size: 14))
                    
                    TextField("Enter your password", text: $password)
                        .autocorrectionDisabled(true)
                        .textInputAutocapitalization(.never)
                        .font(.system(size: 14))
                    
                }//section
                Divider()
            }//vstack
            .padding(.horizontal)
            .padding(.top,50)
            
            Button(action: {
                //validate inputs
                
                //create account using firebaseAuth
                self.createAccount()
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
    
    private func createAccount(){
        Auth.auth().createUser(withEmail: self.email, password: self.password){ authResult, error in
            guard let result = authResult else{
                print(#function, "Unable to create user due to error : \(error)")
                return
            }
            print(#function, "authResult: \(authResult)")
            
            switch(authResult){
            case .none:
                print(#function, "Account creation denied")
            case .some(_):
                print(#function, "Account creation successful")
                
                if (authResult != nil){
                    print(#function, "user info Email : \(authResult!.user.email)")
                }
                
                UserDefaults.standard.set(authResult!.user.email, forKey: "KEY_EMAIL")
                
                self.rootView = .main
                
                //optionally - create User document in the firestore which can have all the profile information
                //profile screen will allow the user to enter or update profile information.
            }
        }
    }//func createAccount
}//struct

//#Preview {
//    SignUpView()
//}
