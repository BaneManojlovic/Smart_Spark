//
//  MockUserDefaultsHelper.swift
//  BITBrainTests
//
//  Created by Branislav Manojlovic on 24.12.24..
//

import Foundation
@testable import BITBrain

/// A test-only implementation of `UserDefaultsHelperProtocol`.
/// Stores values in memory only — no `UserDefaults.standard` is touched during tests.
final class MockUserDefaultsHelper: UserDefaultsHelperProtocol {

    // MARK: - Call tracking

    private(set) var setUserToUserDefaultsCalled = false
    private(set) var emptyUserDefaultsCalled = false

    // MARK: - Stored state

    var mockUser: UserModel?
    var mockApiToken: String?

    // MARK: - UserDefaultsHelperProtocol

    func setUserToUserDefaults(user: UserModel) {
        setUserToUserDefaultsCalled = true
        mockUser = user
    }

    func getUserFromUserDefaults() -> UserModel? {
        return mockUser
    }

    func removeUserFromUserDefaults() {
        mockUser = nil
    }

    func setOpenAiAPIToken(_ apiToken: String) {
        mockApiToken = apiToken
    }

    func getOpenAiAPIToken() -> String? {
        return mockApiToken
    }

    func removeOpenAiAPIToken() {
        mockApiToken = nil
    }

    func emptyUserDefaults() {
        emptyUserDefaultsCalled = true
        mockUser = nil
        mockApiToken = nil
    }
}
