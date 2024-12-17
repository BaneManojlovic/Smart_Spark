//
//  RegistrationView.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 25.10.24..
//

import SwiftUI

struct RegistrationView: View {
    
    @EnvironmentObject private var appRootManager: AppRootManager
    @ObservedObject var authNavViewModel: AuthNavigationViewModel
    @ObservedObject var registerViewModel = RegistrationViewModel()
    @ObservedObject var alertViewModel = AlertViewModel()
    @State private var showingChatScreen = true
    @State private var isLoading = false
    
    var body: some View {
        
        NavigationView {
            ZStack {
                Color(.primaryBlue)
                    .ignoresSafeArea()
                Circle()
                    .scale(1.7)
                    .foregroundColor(.white.opacity(0.25))
                Circle()
                    .scale(1.5)
                    .foregroundColor(.white.opacity(0.50))
                Circle()
                    .scale(1.3)
                    .foregroundColor(.white)
                
                VStack {
                    Text("Registration")
                        .font(.largeTitle)
                        .foregroundStyle(Color.darkBlue)
                        .bold()
                        .padding()
                    TextualCustomTextField(text: $registerViewModel.username,
                                           placeholderText: "Username",
                                           isInputValid: $registerViewModel.profileValidation,
                                           fieldContentType: .nameInvalid)
                    
                    TextualCustomTextField(text: $registerViewModel.emailText,
                                           placeholderText: "Email",
                                           isInputValid: $registerViewModel.profileValidation,
                                           fieldContentType: .emailInvalid)
                    
                    PasswordCustomTextField(text: $registerViewModel.passwordText,
                                            placeholderText: "Password",
                                            isInputValid: $registerViewModel.profileValidation,
                                            fieldContentType: .passwordInvalid)
                    
                    PasswordCustomTextField(text: $registerViewModel.repeatedPasswordText,
                                            placeholderText: "Repeat Password",
                                            isInputValid: $registerViewModel.profileValidation,
                                            fieldContentType: .passwordsDontMatch)
                    
                    
                    Button(action: registerAction) {
                        // Authenticate user
                        HStack {
                            Spacer()
                            Text("Register")
                            Spacer()
                        }
                        .contentShape(Rectangle())
                    }
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background((registerViewModel.username.isEmpty || registerViewModel.emailText.isEmpty || registerViewModel.passwordText.isEmpty || registerViewModel.repeatedPasswordText.isEmpty) ? Color.darkGrayBit : Color.darkBlue)
                    .cornerRadius(10)
                    .padding()
                    .disabled(registerViewModel.username.isEmpty || registerViewModel.emailText.isEmpty || registerViewModel.passwordText.isEmpty || registerViewModel.repeatedPasswordText.isEmpty)
                }
                
                if isLoading {
                    ProgressView()
                        .controlSize(.large)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.3))
                        .foregroundColor(.white)
                        .edgesIgnoringSafeArea(.all)
                }
            }
        }
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden()
        .alert(isPresented: $alertViewModel.showAlert) {
            Alert(title: Text(alertViewModel.alert?.title ?? "Unknown"), message: Text(""), primaryButton: .default(Text("Ok")), secondaryButton: .cancel())
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    authNavViewModel.coordinator.goBack()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                        .font(.title2)
                }
            }
        }
    }
    
    func registerAction() {
        UIApplication.shared.endEditing(true)
        isLoading = true
        registerViewModel.registerAction { success, message  in
            DispatchQueue.main.async {
                isLoading = false
                if success {
                    DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                        appRootManager.currentRoot = .home
                    }
                } else {
                    print("registration failure ...")
                    if let message = message {
                        alertViewModel.presentAlert(alert: CustomAlert(title: message,
                                                                       message: "",
                                                                       primaryButton: .default(Text("Ok")), 
                                                                       secundaryButton: .cancel()))
                    } else {
                        alertViewModel.presentAlert(alert: CustomAlert(title: "You entered invalid data for email or password, please try again with valid data.",
                                                                       message: "",
                                                                       primaryButton: .default(Text("Ok")), 
                                                                       secundaryButton: .cancel()))
                    }
                }
            }
        }
    }
}
