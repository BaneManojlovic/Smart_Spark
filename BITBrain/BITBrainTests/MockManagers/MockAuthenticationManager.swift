//
//  MockAuthenticationManager.swift
//  BITBrainTests
//
//  Created by Branislav Manojlovic on 23.12.24..
//

import Foundation
@testable import BITBrain

/// A test-only implementation of `AuthenticationManagerProtocol`.
/// Conforms to the protocol directly — no Supabase clients are ever created,
/// so tests run without any network setup.
final class MockAuthenticationManager: AuthenticationManagerProtocol {

    // MARK: - Call tracking

    private(set) var registerCallCount = 0
    private(set) var saveUserToDatabaseCallCount = 0
    private(set) var loginCallCount = 0
    private(set) var getUserDataCallCount = 0

    // MARK: - Behavior simulation

    var registerShouldSucceed: Bool
    var simulateSaveError: Error?
    var loginShouldSucceed: Bool
    var simulatedUserId: UUID?
    var simulatedUserData: UserModel?
    var signOutCalled = false
    var mockDownloadResult: AvatarImage?
    var downloadImageCalled = false
    var deleteUserCalled = false
    var deleteUserSuccess = false
    var uploadImageCalled = false
    var mockUploadImageResult: String?
    var mockUpdateUserError: Error?

    init(
        registerShouldSucceed: Bool = true,
        simulateSaveError: Error? = nil,
        loginShouldSucceed: Bool = true,
        simulatedUserId: UUID? = UUID(),
        simulatedUserData: UserModel? = nil
    ) {
        self.registerShouldSucceed = registerShouldSucceed
        self.simulateSaveError = simulateSaveError
        self.loginShouldSucceed = loginShouldSucceed
        self.simulatedUserId = simulatedUserId
        self.simulatedUserData = simulatedUserData
    }

    // MARK: - AuthenticationManagerProtocol

    func login(email: String, password: String) async -> Bool {
        loginCallCount += 1
        return loginShouldSucceed
    }

    func getAuthenticatedUser() async -> UUID? {
        return simulatedUserId
    }

    func register(email: String, password: String) async -> Bool {
        registerCallCount += 1
        return registerShouldSucceed
    }

    func saveUserToDatabase(user: UserModel, completion: @escaping (Error?) -> Void) async {
        saveUserToDatabaseCallCount += 1
        completion(simulateSaveError)
    }

    func updateUserDataInDatabase(user: UserModel, completion: @escaping (Error?) -> Void) async {
        completion(mockUpdateUserError)
    }

    func getUserDataFromDatabase(userId: UUID) async -> UserModel? {
        getUserDataCallCount += 1
        return simulatedUserData
    }

    func signOut() async {
        signOutCalled = true
    }

    func deleteUserFromDatabase(userId: UUID) async throws {
        deleteUserCalled = true
        if !deleteUserSuccess {
            throw NSError(domain: "DeleteUserError", code: 1, userInfo: nil)
        }
    }

    func saveAndUploadUserProfileImage(avatarImageData: Data) async throws -> String? {
        uploadImageCalled = true
        if let result = mockUploadImageResult {
            return result
        } else {
            throw NSError(domain: "UploadImageError", code: 1, userInfo: nil)
        }
    }

    func downloadImage(path: String) async throws -> AvatarImage? {
        downloadImageCalled = true
        return mockDownloadResult
    }

    // MARK: - Assertion helpers

    func wasRegisterCalled() -> Bool { registerCallCount > 0 }
    func wasSaveUserToDatabaseCalled() -> Bool { saveUserToDatabaseCallCount > 0 }
    func wasLoginCalled() -> Bool { loginCallCount > 0 }
    func numberOfRegisterCalls() -> Int { registerCallCount }
    func numberOfSaveUserToDatabaseCalls() -> Int { saveUserToDatabaseCallCount }
    func numberOfLoginCalls() -> Int { loginCallCount }
    func numberOfGetUserDataFromDatabaseCalls() -> Int { getUserDataCallCount }
}
