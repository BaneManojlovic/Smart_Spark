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
    private var registerCallCount = 0
    private var saveUserToDatabaseCallCount = 0

    // Behavior simulation
    var registerShouldSucceed: Bool
    var simulateSaveError: Error?

    init(registerShouldSucceed: Bool = true, simulateSaveError: Error? = nil) {
        self.registerShouldSucceed = registerShouldSucceed
        self.simulateSaveError = simulateSaveError
    }

    override func register(email: String, password: String) async -> Bool {
        registerCallCount += 1
        return registerShouldSucceed
    }

    override func getAuthenticatedUser() async -> UUID? {
        return UUID()
    }

    override func saveUserToDatabase(user: UserModel, completion: @escaping (Error?) -> Void) async {
        saveUserToDatabaseCallCount += 1
        completion(simulateSaveError)
    }

    // Utility methods for test assertions
    func wasRegisterCalled() -> Bool {
        return registerCallCount > 0
    }

    func wasSaveUserToDatabaseCalled() -> Bool {
        return saveUserToDatabaseCallCount > 0
    }

    func numberOfRegisterCalls() -> Int {
        return registerCallCount
    }

    func numberOfSaveUserToDatabaseCalls() -> Int {
        return saveUserToDatabaseCallCount
    }
}
