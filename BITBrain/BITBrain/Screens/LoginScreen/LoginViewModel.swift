//
//  LoginViewModel.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 26.10.24..
//

import Foundation

class LoginViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published var emailText: String = ""
    @Published var passwordText: String = ""
    @Published var isLoading = false
    @Published var alertMessage: AlertMessage? = nil
    @Published var profileValidation: [ValidationError: Bool] = [.nameInvalid: false, .emailInvalid: false]

    // MARK: - Properties

    var authService = AuthenticationManager()
    var userDefaultsHelper = UserDefaultsHelper()

    // MARK: - Methods

    func loginUser(completion: @escaping (Bool) -> Void) {
        isLoading = true
        Task {
            let email = emailText
            let password = passwordText
            let userId = await self.login(email: email, password: password)
            
            DispatchQueue.main.async {
                self.isLoading = false
                if let userId {
                    self.saveUserDataToDatabase(userId: userId)
                    completion(true)
                } else {
                    self.alertMessage = AlertMessage(message: "You entered wrong email or password, please try again with valid credentials.")
                    completion(false)
                }
            }
        }
    }
    
    private func login(email: String, password: String) async -> UUID? {
            let userLoggedIn = await authService.login(email: email, password: password)
            if userLoggedIn {
                return await authService.getAuthenticatedUser()
            } else {
                return nil
            }
        }


    func saveUserDataToDatabase(userId: UUID) {
        Task {
            if let user = await authService.getUserDataFromDatabase(userId: userId) {
                self.saveUserData(user: user)
            }
        }
    }

    func saveUserData(user: UserModel) {
        userDefaultsHelper.setUserToUserDefaults(user: user)
    }
}
