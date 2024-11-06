//
//  LoginView.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 24.10.24..
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject private var appRootManager: AppRootManager
//    @EnvironmentObject var appState: AppState

    @ObservedObject var authNavViewModel: AuthNavigationViewModel
    @ObservedObject var loginViewModel = LoginViewModel()
//    @ObservedObject var alertViewModel: AlertViewModel
    
    @State private var username = ""
    @State private var password = ""
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var showingChatScreen = true
    
    var body: some View {
    
            NavigationView {
                ZStack {
                    Color.black
                        .ignoresSafeArea()
                    Circle()
                        .scale(1.7)
                        .foregroundColor(.white.opacity(0.25))
                    Circle()
                        .scale(1.35)
                        .foregroundColor(.white)
                    
                    
                    VStack {
                        Text("Login")
                            .font(.largeTitle)
                            .foregroundStyle(Color.black)
                            .bold()
                            .padding()
                        TextField("Username", text: $username)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.black.opacity(0.08))
                            .cornerRadius(10)
                            .border(.red, width: CGFloat(wrongUsername))
                        SecureField("Password", text: $password)
                            .padding()
                            .frame(width: 300, height: 50)
                            .background(Color.black.opacity(0.08))
                            .cornerRadius(10)
                            .border(.red, width: CGFloat(wrongPassword))
                        
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
                        .background(Color.black)
                        .cornerRadius(10)
                        
                        Button("Register new user") {
                            // Register user
                            authNavViewModel.coordinator.navigateToRegistration()
                        }
                        .foregroundColor(.blue)
                        
                      
                    }
                }
    
            }
            .navigationBarHidden(true)
            .applyNavigation(coordinator: authNavViewModel.coordinator)
        
    }
    
    func loginAction() {
        Task {
            let email = "bane1@gmail.com"
            let password = "BakiMaki106@"
            let user = await loginViewModel.login(email: email, password: password)
            
            if user != nil {
                appRootManager.currentRoot = .home
            } else {
                print("login failed")
            }
        }
    }

//    // TODO: - Ovu metodu, posalji prilikom validacije email-a
//    func checkForExistingUser() {
//        Task {
//            let email = "bane1@gmail.com" // Replace this with the actual email input if needed
//            let userExists = await checkForUser(email: email)
//            
//            if userExists {
//                appRootManager.currentRoot = .home
//            } else {
//                // Handle the case where the user does not exist
//                print("User does not exist.")
//            }
//        }
//    }
    
//    func checkForUser(email: String) async -> Bool {
//        let userExists = await loginViewModel.checkForUser(email: email)
//        return userExists
//    }
    
    func authenticateUser(username: String, password: String) async {
//        // TODO: - Make a proper authentification
//        if username.lowercased() == "baki123" {
//            wrongUsername = 0
//            
//            if password.lowercased() == "baki123" {
//                wrongPassword = 0
//                showingChatScreen = true
//                
//            } else {
//                wrongPassword = 2
//            }
//            
//        } else {
//            wrongUsername = 2
//        }
    }
}
//
//#Preview {
//    LoginView()
//}
