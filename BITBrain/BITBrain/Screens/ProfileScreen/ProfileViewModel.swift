//
//  ProfileViewModel.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 14.11.24..
//

import Foundation

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
            return "\(user.id)"
        } else {
            return "--"
        }
    }
    
    func getUsername() -> String? {
        if let user = userDefaultsHelper.getUser() {
            return user.username
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
        if let userId = userDefaultsHelper.getUser()?.id {
            do {
                let _: () = try await authService.deleteUser(userId: userId)
                userDefaultsHelper.emptyUserDefaults()
                return true
            } catch {
                return false
            }
        } else {
            return false
        }
    }
}
