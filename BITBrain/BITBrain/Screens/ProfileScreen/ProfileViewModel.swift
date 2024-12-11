//
//  ProfileViewModel.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 14.11.24..
//

import Foundation
import FirebaseAuth
import FirebaseAnalytics

class ProfileViewModel: ObservableObject {
    
    let userDefaultsHelper = UserDefaultsHelper()
    let authService = AuthenticationManager()
    
    func showUserData() -> String {
        if let user = userDefaultsHelper.getUser() {
            return "\(user.email ?? "")"
        } else {
            return "--"
        }
        
    }
    
    func getUserId() -> String {
        if let user = userDefaultsHelper.getUser() {
            return "\(user.uid)"
        } else {
            return "--"
        }
    }
    
    func deleteAction(completion: @escaping (Bool) -> Void) {
        Task {
            let result = await self.deleteAccount()
            completion(result)
        }
    }
    
    func deleteAccount() async -> Bool {
        do {
            let _: () = try await authService.deleteUser()
            Analytics.logEvent("user_deleted", parameters: nil)
            userDefaultsHelper.emptyUserDefaults()
            return true
        } catch {
            return false
        }
    }
}
