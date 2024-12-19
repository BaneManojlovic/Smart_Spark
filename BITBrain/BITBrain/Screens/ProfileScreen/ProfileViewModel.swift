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
    @Published var avatarImage: AvatarImage?

    // MARK: - Methods

    func fetchUserData() {
        if let user = userDefaultsHelper.getUserFromUserDefaults() {
            print("Bane - userModel iz baze je = \(user.id), \(user.username), \(user.email), \(user.photoUrl)")
            userModel = UserModel(id: user.id,
                                  username: user.username,
                                  email: user.email,
                                  photoUrl: user.photoUrl)
            downloadImage(path: user.photoUrl ?? "")
        } else {
            userModel = nil
        }
    }
    
    func downloadImage(path: String) {
        Task {
            do {
                
                let result = try await authService.downloadImage(path: path)
                if let imageData =  result?.data {
                    let avatar = AvatarImage(data: imageData)
                    await MainActor.run {
                        self.avatarImage = avatar
                    }
                }
            } catch {
                print("avatar error..")
            }
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
    
    func updateProfile(imageData: Data) async {
        do {
            let imageUrl = try await authService.saveAndUploadUserProfileImage(avatarImageData: imageData)
            print("Bane = image url = \(imageUrl)")
            guard let user = self.userModel else { return }
            
            let updatedUserModel = UserModel(id: user.id,
                                             username: user.username,
                                             email: user.email,
                                             photoUrl: imageUrl)
            
            await authService.updateUserDataInDatabase(user: updatedUserModel) { error in
                if let error {
                    print("Bane - ", error.localizedDescription)
                } else {
                    print("success...")
                    self.userDefaultsHelper.setUserToUserDefaults(user: updatedUserModel)
                }
            }
        } catch {
            print("error")
        }
    }

}
