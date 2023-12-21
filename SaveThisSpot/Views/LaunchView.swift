//
//  LaunchView.swift
//  SaveThisSpot
//
// Group 8
// Zubear Nassimi id# 991 628 529
// Shehnazdeep Kaur id# 991 539 256
//

import SwiftUI

struct LaunchView: View {
    
    @State private var rootView : RootView = .login
    let fireDBHelper : FireDBHelper = FireDBHelper.getInstance()
    
    var body: some View {
        NavigationStack{
            switch self.rootView {
            case .login:
                SignInView(rootView: self.$rootView)
            case .main:
                MainView(rootView: self.$rootView).environmentObject(self.fireDBHelper)
            }//switch case
        }//navigationStack
    }//body
}//struct

//#Preview {
//    LaunchView()
//}
