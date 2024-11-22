//
//  PasswordCustomTextField.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 22.11.24..
//

import Foundation
import SwiftUI

struct PasswordCustomTextField: View {
    
    var text: Binding<String>
    var placeholderText: String
    //    @Binding var passwordText: String
    @Binding var isInputValid: [ValidationError: Bool]
    var fieldContentType: ValidationError
    @State private var errorMessage = ""
    @State private var isSecured: Bool = true
    
    var body: some View {
        HStack {
            
            ZStack(alignment: .trailing) {
                
                Group {
                    if isSecured {
                        BaseSecureTextFieldView(placeholderText: placeholderText,
                                                backgroundColor: Color.black.opacity(0.08),
                                                text: text)
                    } else {
                        BaseTextFieldView(placeholderText: placeholderText,
                                          backgroundColor: Color.black.opacity(0.08),
                                          text: text)
                    }
                }
                .keyboardType(.default)
                .overlay(RoundedRectangle(cornerRadius: 10.0)
                    .stroke(isInputValid[fieldContentType] == true || text.wrappedValue.isEmpty ? Color.clear : Color.red, lineWidth: 1))
                .onChange(of: text.wrappedValue) { newValue in
                    
                    switch fieldContentType {
                        
                    case .passwordInvalid:
                        let result =  StringHelper.validatePassword(text: newValue)
                        if let message = result.0.errorMessages {
                            errorMessage = message
                        }
                        if result.1 == true && !newValue.isEmpty {
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
                SecuredEyeButtonView(isSecured: $isSecured)
            }
        }
    }
}
