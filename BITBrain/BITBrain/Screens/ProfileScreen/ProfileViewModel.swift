//
//  ProfileViewModel.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 14.11.24..
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    // MARK: - Properties

    let userDefaultsHelper = UserDefaultsHelper()
    let authService = AuthenticationManager()
    
    // MARK: - Published properties
    
    @Published var userModel: UserModel?

    // MARK: - Methods

    func fetchUserData() {
        if let user = userDefaultsHelper.getUserFromUserDefaults() {
            print("Bane - userModel iz baze je = \(user.id), \(user.username), \(user.email), \(user.photoUrl)")
            userModel = UserModel(id: user.id,
                                  username: user.username,
                                  email: user.email,
                                  photoUrl: user.photoUrl)
        } else {
            userModel = nil
        }
    }

    func deleteAction(completion: @escaping (Bool) -> Void) {
        Task {
            let result = await self.deleteAccount()
            if result {
                userModel = nil
            }
            completion(result)
        }
    }
    
    func deleteAccount() async -> Bool {
        if let userId = userModel?.id {
            do {
                try await authService.deleteUserFromDatabase(userId: userId)
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
