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
    @Published var profileValidation: [ValidationError: Bool] = [.nameInvalid: false, .emailInvalid: false]

    let authService = AuthenticationManager()
    let userDefaultsHelper = UserDefaultsHelper()
    
    func loginAction(completion: @escaping (Bool) -> Void) {
        Task {
            let email = emailText
            let password = passwordText
            let user = await self.login(email: email, password: password)
            
            if let userData = user {
                self.saveUserData(user: userData)
                completion(true)
                
            } else {
                print("login failed")
                completion(false)
            }
        }
    }
    
    func login(email: String, password: String) async -> UserModel? {
        do {
            let user = try await authService.login(email: email, password: password)
            print("User = \(String(describing: user?.email))")
            Analytics.logEvent("login", parameters: nil)
            return user
        } catch {
            print("login failed")
            return nil
        }
    }

    func saveUserData(user: UserModel) {
        userDefaultsHelper.setUser(user: user)
    }
}
