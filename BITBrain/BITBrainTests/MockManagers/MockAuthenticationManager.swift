//
//  MockAuthenticationManager.swift
//  BITBrainTests
//
//  Created by Branislav Manojlovic on 23.12.24..
//

import Foundation
import XCTest
@testable import BITBrain

class MockAuthenticationManager: AuthenticationManager {
    // Call tracking
    /// for Registration
    private var registerCallCount = 0
    private var saveUserToDatabaseCallCount = 0
    /// for Login
    private var loginCallCount = 0
    private var getUserDataCallCount = 0

    // Behavior simulation
    /// for Registration
    var registerShouldSucceed: Bool
    var simulateSaveError: Error?
    /// for Login
    var loginShouldSucceed: Bool
    var simulatedUserId: UUID?
    var simulatedUserData: UserModel?

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

    // MARK: - Registration Methods

    override func register(email: String, password: String) async -> Bool {
        registerCallCount += 1
        return registerShouldSucceed
    }

    override func getAuthenticatedUser() async -> UUID? {
        return simulatedUserId
    }

    override func saveUserToDatabase(user: UserModel, completion: @escaping (Error?) -> Void) async {
        saveUserToDatabaseCallCount += 1
        completion(simulateSaveError)
    }
    
    // MARK: - Login methods

    override func login(email: String, password: String) async -> Bool {
        loginCallCount += 1
        return loginShouldSucceed
    }

    override func getUserDataFromDatabase(userId: UUID) async -> UserModel? {
        getUserDataCallCount += 1
        return simulatedUserData
    }

    // MARK: - Utility methods for test assertions

    func wasRegisterCalled() -> Bool {
        return registerCallCount > 0
    }

    func wasSaveUserToDatabaseCalled() -> Bool {
        return saveUserToDatabaseCallCount > 0
    }
    
    func wasLoginCalled() -> Bool {
        print("Bane - wasLoginCalled() \(loginCallCount)")
        return loginCallCount > 0
    }

    func numberOfRegisterCalls() -> Int {
        return registerCallCount
    }

    func numberOfSaveUserToDatabaseCalls() -> Int {
        return saveUserToDatabaseCallCount
    }
    
    func numberOfLoginCalls() -> Int {
        return loginCallCount
    }

    func numberOfGetUserDataFromDatabaseCalls() -> Int {
        return getUserDataCallCount
    }
}
