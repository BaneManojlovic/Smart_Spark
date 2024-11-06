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
    
//    @Published var email = ""
//    @Published var password = ""
    
    let authService = AuthenticationManager()
    
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
    
    
}
