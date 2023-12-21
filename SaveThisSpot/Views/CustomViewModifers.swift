//
//  CustomViewModifers.swift
//  SaveThisSpot
//
// Group 8
// Zubear Nassimi id# 991 628 529
// Shehnazdeep Kaur id# 991 539 256
//

import SwiftUI

struct AppTextFieldModifier: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .padding(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 2)
            )
            .padding(10)
    }
}

struct AppButtonModifier: ViewModifier {
    var font: Font = .title
    func body(content: Content) -> some View {
        return content
            .frame(maxWidth: .infinity)
            .background(Color.blue)
            .cornerRadius(10)
            .padding(.top, 50)
            .padding(.horizontal, 10)
    }
}

struct AppButtonTextModifier: ViewModifier{
    var font: Font = .title
    func body(content: Content) -> some View {
        return content
            .foregroundColor(Color.white)
            .font(.body)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
    }
}

