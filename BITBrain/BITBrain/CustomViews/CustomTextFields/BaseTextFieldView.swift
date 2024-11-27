//
//  BaseTextFieldView.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 22.11.24..
//

import Foundation
import SwiftUI

struct BaseTextFieldView: View {
    
    var placeholderText: String
    var backgroundColor: Color
    @Binding var text: String
    
    var body: some View {
        
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholderText)
                    .foregroundColor(.gray)
                    .padding(.leading, 16)
            }
            TextField("", text: $text)
                .tint(Color.primaryBlue)
                .foregroundColor(Color.darkBlue)
                .padding()
                .frame(width: 300, height: 50)
                .disableAutocorrection(true)
                .textInputAutocapitalization(.never)
                .background(backgroundColor)
                .cornerRadius(10)
        }
    }
}
