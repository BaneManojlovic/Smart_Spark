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
    
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var repeatedPassword = ""
    @State private var badEmail = 0
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State private var passwordsDontMatch = 0
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
                    Text("Registration")
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
                    TextField("Email", text: $email)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.08))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(badEmail))
                    SecureField("Password", text: $password)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.08))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(wrongPassword))
                    SecureField("Repeat Password", text: $repeatedPassword)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.08))
                        .cornerRadius(10)
                        .border(.red, width: CGFloat(passwordsDontMatch))
                    
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
                    .background(Color.black)
                    .cornerRadius(10)
                }
            }
        }
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    authNavViewModel.coordinator.goBack()
                }) {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.white)
                        .font(.title2)
                }
            }
        }
    }
    
    func registerAction() {
        registerUser()
    }
    
    func registerUser() {
        Task {
            let email = "bane2@gmail.com"
            let password = "BakiMaki106@"
            let user = await registerViewModel.registerNewUser(email: email, password: password)
            
            if user != nil {
                appRootManager.currentRoot = .home
            } else {
                print("registration failed")
            }
        }
    }
    
//    func reguisterNewUser(username: String,
//                          email: String,
//                          password: String,
//                          repeatedPassword: String) {
//
//        // TODO: - Make proper validation
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
//    }
}

//#Preview {
//    RegistrationView()
//}
