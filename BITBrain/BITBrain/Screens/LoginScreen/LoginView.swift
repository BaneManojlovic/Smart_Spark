//
//  LoginView.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 24.10.24..
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject private var appRootManager: AppRootManager
    @ObservedObject var authNavViewModel: AuthNavigationViewModel
    @ObservedObject var loginViewModel = LoginViewModel()
    
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
                        Text("Login")
                            .font(.largeTitle)
                            .foregroundStyle(Color.darkBlue)
                            .bold()
                            .padding()
                        TextualCustomTextField(text: $loginViewModel.emailText,
                                               placeholderText: "Email",
                                               isInputValid: $loginViewModel.profileValidation,
                                               fieldContentType: .emailInvalid)
                        
                        PasswordCustomTextField(text: $loginViewModel.passwordText,
                                                placeholderText: "Password",
                                                isInputValid: $loginViewModel.profileValidation,
                                                fieldContentType: .passwordInvalid)
                        
                        Button(action: {
                            loginViewModel.loginUser { success in
                                if success {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        appRootManager.currentRoot = .home
                                    }
                                }
                            }
                        }) {
                            HStack {
                                Spacer()
                                Text("Login")
                                Spacer()
                            }
                            .contentShape(Rectangle())
                        }
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background((loginViewModel.emailText.isEmpty || loginViewModel.passwordText.isEmpty) ? Color.darkGrayBit : Color.darkBlue)
                        .cornerRadius(10)
                        .padding()
                        .disabled(loginViewModel.emailText.isEmpty || loginViewModel.passwordText.isEmpty)
                        
                        Button("Register new user") {
                            authNavViewModel.coordinator.navigateToRegistration()
                        }
                        .foregroundColor(.blue)
                    }
                    
                    if loginViewModel.isLoading {
                        ProgressView()
                            .controlSize(.large)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color.black.opacity(0.3))
                            .foregroundColor(.white)
                            .tint(.darkGrayBit)
                            .edgesIgnoringSafeArea(.all)
                    }
                    
                }
    
            }
            .navigationBarHidden(true)
            .alert(item: $loginViewModel.alertMessage) { alertMessage in
                Alert(title: Text(alertMessage.message))
            }
            .applyNavigation(coordinator: authNavViewModel.coordinator)
        
    }
}
