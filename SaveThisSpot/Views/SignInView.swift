//
//  SignInView.swift
//  SaveThisSpot
//
// Group 8
// Zubear Nassimi id# 991 628 529
// Shehnazdeep Kaur id# 991 539 256
//

import SwiftUI
import FirebaseAuth

struct SignInView: View {
    
    @Binding var rootView : RootView
    
    @State private var email : String = "user8@gmail.com"
    @State private var password : String = "pass1234"
    @State private var showingAlert = false
    @State private var errorMessage : String = ""
    
    var body: some View {
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
                
                VStack(alignment: .leading, spacing: 12){
                    Section(){
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
                           
                    }
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
                            
                    }
                    Divider()
                }//vstack
                .padding(.horizontal)
                .padding(.top,80)
              
                Button(action: {
                        //behavior/operation
                    self.displayError()
                    self.login()
                  
                }){
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
                //Navigation Link to Sign-Up Page
                NavigationLink{
                    SignUpView(rootView: self.$rootView)
                }label:{
                    HStack(spacing: 3){
                        
                        Text("Doesn't have an account?")
                        Text("Sign Up")
                            .fontWeight(.bold)
                    }
                    .font(.system(size: 14))
                }
                
            }//Vstack
    }//body
    
    private func displayError(){
        if(self.email.isEmpty || self.password.isEmpty ){
            self.errorMessage = "Please fill all the fields!!"
            self.showingAlert = true
        }
    }
    
    private func login(){
        Auth.auth().signIn(withEmail: self.email, password: self.password){ authResult, error in
            guard let result = authResult else{
                print(#function, "Unable to sign in due to error : \(error)")
                return
            }
            print(#function, "authResult: \(authResult)")
            
            switch(authResult){
            case .none:
                print(#function, "Unsuccessful sign in attempt")
            case .some(_):
                print(#function, "Login successful")
                
                if (authResult != nil){
                    print(#function, "user info Email : \(authResult!.user.email)")
                    print(#function, "user info Name : \(authResult!.user.displayName)")
                }
                
                UserDefaults.standard.set(authResult!.user.email, forKey: "KEY_EMAIL")
                
                //modify the root view value to replace the SignInView() with Mainview in the NavigationStack
                self.rootView = .main
            }
        }
    }//func login
}//struct

//#Preview {
//    SignInView(rootView: rootView)
//}
