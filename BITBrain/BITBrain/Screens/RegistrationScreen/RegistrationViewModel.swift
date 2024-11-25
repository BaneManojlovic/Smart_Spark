//
//  RegistrationViewModel.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 30.10.24..
//

import Foundation
import FirebaseAuth
import FirebaseAnalytics

class RegistrationViewModel: ObservableObject {
    
    @Published var username: String = ""
    @Published var emailText: String = ""
    @Published var passwordText: String = ""
    @Published var repeatedPasswordText: String = ""
    @Published var profileValidation: [ValidationError: Bool] = [.nameInvalid: false, .emailInvalid: false]

    let authService = AuthenticationManager()
    let userDefaultsHelper = UserDefaultsHelper()

    func registerAction(completion: @escaping (Bool) -> Void) {
        Task {
            let email = emailText
            let password = passwordText
            let newUser = await self.registerNewUser(email: email, password: password)

            if let newUserData = newUser {
                self.saveUserData(user: newUserData)
                completion(true)
            } else {
                print("registration failed")
                completion(false)
            }
        }
    }

    // MARK: - Calling API endpoint
    func registerNewUser(email: String, password: String) async -> UserModel? {
        do {
            let user = try await authService.register(email: email, password: password)
            print("User = \(String(describing: user))")
            Analytics.logEvent("sign_up", parameters: nil)
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
