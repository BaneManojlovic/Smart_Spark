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
        
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholderText)
                    .foregroundColor(.gray) // Explicit placeholder color
                    .padding(.leading, 16)
            }
            SecureField("", text: $text)
                .tint(Color.primaryBlue)
                .foregroundColor(Color.darkBlue)
                .padding()
                .frame(width: 300, height: 50)
                .background(backgroundColor)
                .cornerRadius(10)
        }
    }
}
