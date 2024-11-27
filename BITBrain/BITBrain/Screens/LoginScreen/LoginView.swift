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
    @ObservedObject var alertViewModel = AlertViewModel()
    @State private var password = ""
    @State private var wrongPassword = 0
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
                        
                        Button(action: loginAction) {
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
                            // Register user
                            authNavViewModel.coordinator.navigateToRegistration()
                        }
                        .foregroundColor(.blue)
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
            .navigationBarHidden(true)
            .alert(isPresented: $alertViewModel.showAlert) {
                Alert(title: Text(alertViewModel.alert?.title ?? "Unknown"), message: Text(""), primaryButton: .default(Text("Ok")), secondaryButton: .cancel())
            }
            .applyNavigation(coordinator: authNavViewModel.coordinator)
        
    }
    
    func loginAction() {
        isLoading = true
        loginViewModel.loginAction { success in
            DispatchQueue.main.async {
                isLoading = false
                if success {
                    DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                        appRootManager.currentRoot = .home
                    }
                } else {
                    print("login failure ...")
                    // show Alert
                    alertViewModel.presentAlert(alert: CustomAlert(title: "You entered wrong email or password, please try again with valid credentials.",
                                                                   message: "",
                                                                   primaryButton: .default(Text("Ok")), secundaryButton: .cancel()))
                }
            }
        }
    }
}
/*
 let email = "bane1@gmail.com"
 let password = "BakiMaki106@"
 */
