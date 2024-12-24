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

    var authService = AuthenticationManager()
    var userDefaultsHelper = UserDefaultsHelper()
    
    func loginAction(completion: @escaping (Bool) -> Void) {
        Task {
            let email = emailText
            let password = passwordText
            let userId = await self.login(email: email, password: password)
            
            if let userId {
                let user = await self.getUserDataFromDatabase(userId: userId)
                completion(true)
            } else {
                print("login failed")
                completion(false)
            }
        }
    }

    // MARK: - Calling API endpoint
    func login(email: String, password: String) async -> UUID? {
        let userLoggedIn = await authService.login(email: email, password: password)
        if userLoggedIn {
            let userId = await authService.getAuthenticatedUser()
            print("User = \(String(describing: userId))")
            return userId
        } else {
            return nil
        }
    }
    
    func getUserDataFromDatabase(userId: UUID) async -> UserModel? {
        if let user = await authService.getUserDataFromDatabase(userId: userId) {
            self.saveUserData(user: user)
            return user
        } else {
            return nil
        }
    }

    func saveUserData(user: UserModel) {
        userDefaultsHelper.setUserToUserDefaults(user: user)
    }
}
