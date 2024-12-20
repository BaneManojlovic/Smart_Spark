//
//  TextualCustomTextField.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 22.11.24..
//

import Foundation
import SwiftUI

struct TextualCustomTextField: View {
    
    var text: Binding<String>
    var placeholderText: String
    @Binding var isInputValid: [ValidationError: Bool]
    var fieldContentType: ValidationError
    @State private var errorMessage = ""
    
    var body: some View {
        HStack {
            BaseTextFieldView(placeholderText: placeholderText, backgroundColor: Color.black.opacity(0.08), text: text)
                .keyboardType(.default)
                .overlay(RoundedRectangle(cornerRadius: 10.0)
                    .stroke(isInputValid[fieldContentType] == true || text.wrappedValue.isEmpty ? Color.clear : Color.red, lineWidth: 1))
                .onChange(of: text.wrappedValue) { newValue in
                    switch fieldContentType {
                    case .emailInvalid:
                        if StringHelper.isEmailValid(newValue) {
                            isInputValid[fieldContentType] = true
                        } else {
                            $errorMessage.wrappedValue = "Error Message Email Invalid Format"
                            isInputValid[fieldContentType] = false
                        }
                    case .nameInvalid:
                        if StringHelper.isFullNameValid(newValue) {
                            $errorMessage.wrappedValue = "Error Message Name Invalid Format"
                            isInputValid[fieldContentType] = true
                        } else {
                            isInputValid[fieldContentType] = false
                        }
                    default:
                        if newValue.isEmpty {
                            isInputValid[fieldContentType] = false
                        } else {
                            isInputValid[fieldContentType] = true
                        }
                    }
                }
        }
    }
}
