//
//  ProfileViewModel.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 14.11.24..
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    // MARK: - Properties

    var userDefaultsHelper: UserDefaultsHelperProtocol
    var authService: AuthenticationManagerProtocol

    // MARK: - Init

    init(authService: AuthenticationManagerProtocol = AuthenticationManager.shared,
         userDefaultsHelper: UserDefaultsHelperProtocol = UserDefaultsHelper()) {
        self.authService = authService
        self.userDefaultsHelper = userDefaultsHelper
    }
    
    // MARK: - Published properties
    
    @Published var userModel: UserModel?
    @Published var avatarImage: AvatarImage?
    @Published var isAvatarLoading: Bool = false

    // MARK: - Methods

    func fetchUserData() {
        if let user = userDefaultsHelper.getUserFromUserDefaults() {
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
            await MainActor.run {
                self.isAvatarLoading = true
            }
            do {
                let result = try await authService.downloadImage(path: path)
                if let imageData =  result?.data {
                    let avatar = AvatarImage(data: imageData)
                    await MainActor.run {
                        self.avatarImage = avatar
                        self.isAvatarLoading = false
                    }
                }
            } catch {
                await MainActor.run { self.isAvatarLoading = false }
                print("avatar error..")
            }
        }
    }
    
    func deleteAccount(onSuccess: @escaping () -> Void, onError: @escaping () -> Void) {
        Task {
            guard let userId = userModel?.id else {
                DispatchQueue.main.async {
                    onError()
                }
                return
            }
            
            do {
                try await authService.deleteUserFromDatabase(userId: userId)
                userDefaultsHelper.emptyUserDefaults()
                DispatchQueue.main.async {
                    self.userModel = nil
                    onSuccess()
                }
            } catch {
                DispatchQueue.main.async {
                    onError()
                }
            }
        }
    }
    
    func saveProfile(imageData: Data?) async {
        guard let imageData = imageData else { return }

        do {
            let imageUrl = try await authService.saveAndUploadUserProfileImage(avatarImageData: imageData)

            guard let user = self.userModel else { return }

            let updatedUserModel = UserModel(id: user.id,
                                             username: user.username,
                                             email: user.email,
                                             photoUrl: imageUrl)
            self.userModel = updatedUserModel

            await authService.updateUserDataInDatabase(user: updatedUserModel) { error in
                if let error {
                    print(error.localizedDescription)
                } else {
                    self.userDefaultsHelper.setUserToUserDefaults(user: updatedUserModel)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}
