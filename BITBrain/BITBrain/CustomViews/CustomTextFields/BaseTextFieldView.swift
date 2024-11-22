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
        TextField(placeholderText, text: $text)
            .padding()
            .frame(width: 300, height: 50)
            .disableAutocorrection(true)
            .textInputAutocapitalization(.never)
            .background(backgroundColor)
            .cornerRadius(10)
    }
}
