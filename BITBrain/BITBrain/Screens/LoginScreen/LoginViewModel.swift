//
//  LoginViewModel.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 26.10.24..
//

import Foundation

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

    // MARK: - Calling API endpoint
    func login(email: String, password: String) async -> UserModel? {
        let userLoggedIn = await authService.login(email: email, password: password)
        if userLoggedIn {
            let user = await authService.getAuthenticatedUser()
            print("User = \(String(describing: user?.email))")
            return user
        } else {
            return nil
        }
    }

    func saveUserData(user: UserModel) {
        userDefaultsHelper.setUser(user: user)
    }
}
