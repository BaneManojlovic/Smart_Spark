//
//  RegistrationViewModel.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 30.10.24..
//

import Foundation

class RegistrationViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var emailText: String = ""
    @Published var passwordText: String = ""
    @Published var repeatedPasswordText: String = ""
    @Published var profileValidation: [ValidationError: Bool] = [.nameInvalid: false, .emailInvalid: false, .passwordInvalid: false, .passwordsDontMatch: false]

    let authService = AuthenticationManager()
    let userDefaultsHelper = UserDefaultsHelper()

    // MARK: - Methods for API calling

    func registerAction(completion: @escaping (Bool, String?) -> Void) {
        Task {
            let email = emailText
            let password = passwordText
            let repeatedPassword = repeatedPasswordText
            let username = username
            
            if password == repeatedPassword {
                let newUser = await self.registerNewUser(email: email, password: password)

                if let newUserData = newUser {
                    self.saveUserData(user: newUserData)
                    completion(true, nil)
                } else {
                    completion(false, "Registration failed, please try again.")
                }
            } else {
                completion(false, "Passwords do not match.")
            }
        }
    }

    func registerNewUser(email: String, password: String) async -> UserModel? {
        do {
            let user = try await authService.register(email: email, password: password)
            return user
        } catch {
            print("error")
            return nil
        }
    }
    
    func saveUserData(user: UserModel) {
        userDefaultsHelper.setUser(user: user)
    }
}
