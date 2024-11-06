//
//  LoginViewModel.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 26.10.24..
//

import Foundation
import FirebaseAuth
import FirebaseAnalytics

class LoginViewModel: ObservableObject {
    
    @Published var emailText: String = ""
    @Published var passwordText: String = ""
    @Published var isLoading = false
    @Published var userExists = false
    @Published var isPasswordVisible = false

    let authService = AuthenticationManager()
    
    func login(email: String, password: String) async -> UserModel? {
        do {
            let user = try await authService.login(email: email, password: password)
            print("User = \(user?.email)")
            Analytics.logEvent("login", parameters: nil)
            return user
        } catch {
            print("login failed")
            return nil
        }
    }
}
