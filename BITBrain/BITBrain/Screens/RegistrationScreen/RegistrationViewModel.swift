//
//  RegistrationViewModel.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 30.10.24..
//

import Foundation

class RegistrationViewModel: ObservableObject {
    
    // MARK: - Published properties
    
    @Published var username: String = ""
    @Published var emailText: String = ""
    @Published var passwordText: String = ""
    @Published var repeatedPasswordText: String = ""
    @Published var profileValidation: [ValidationError: Bool] = [.nameInvalid: false, .emailInvalid: false, .passwordInvalid: false, .passwordsDontMatch: false]
    @Published var isLoading: Bool = false
    @Published var alertMessage: AlertMessage? = nil
    
    // MARK: - Properties

    var authService: AuthenticationManagerProtocol
    var userDefaultsHelper: UserDefaultsHelperProtocol

    // MARK: - Init

    init(authService: AuthenticationManagerProtocol = AuthenticationManager.shared,
         userDefaultsHelper: UserDefaultsHelperProtocol = UserDefaultsHelper()) {
        self.authService = authService
        self.userDefaultsHelper = userDefaultsHelper
    }

    // MARK: - Methods for API calling
    
    func registerUser(completion: @escaping (Bool) -> Void) {
        isLoading = true
        Task {
            if passwordText != repeatedPasswordText {
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.alertMessage = AlertMessage(message: "Passwords do not match.")
                    completion(false)
                }
                return
            }
            
            let userId = await registerNewUser(email: emailText, password: passwordText)
            DispatchQueue.main.async {
                self.isLoading = false
                if let userId {
                    let userModel = UserModel(id: userId, username: self.username, email: self.emailText, photoUrl: nil)
                    self.saveUserData(user: userModel)
                    self.saveUserDataToDatabase(user: userModel)
                    completion(true)
                } else {
                    self.alertMessage = AlertMessage(message: "Registration failed, please try again.")
                    completion(false)
                }
            }
        }
    }

    func registerNewUser(email: String, password: String) async -> UUID? {
        let userRegisteredSuccessfully = await authService.register(email: email, password: password)
        if userRegisteredSuccessfully {
            return await authService.getAuthenticatedUser()
        }
        return nil
    }
    
    func saveUserData(user: UserModel) {
        userDefaultsHelper.setUserToUserDefaults(user: user)
    }
    
    func saveUserDataToDatabase(user: UserModel, taskCompletion: (() -> Void)? = nil) {
        Task {
            await authService.saveUserToDatabase(user: user) { error in
                if let error {
                    print(error.localizedDescription)
                }
                taskCompletion?() // Call the completion handler after the task is finished
            }
        }
    }
}
