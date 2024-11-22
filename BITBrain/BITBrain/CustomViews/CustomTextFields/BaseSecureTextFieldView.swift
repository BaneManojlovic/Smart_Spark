//
//  BaseSecureTextFieldView.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 22.11.24..
//

import Foundation
import SwiftUI


struct BaseSecureTextFieldView: View {

    var placeholderText: String
    var backgroundColor: Color
    @Binding var text: String

    var body: some View {
        SecureField(placeholderText, text: $text)
            .padding()
            .frame(width: 300, height: 50)
            .background(backgroundColor)
            .cornerRadius(10)
    }
}
