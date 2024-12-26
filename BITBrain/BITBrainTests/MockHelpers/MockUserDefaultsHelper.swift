//
//  MockUserDefaultsHelper.swift
//  BITBrainTests
//
//  Created by Branislav Manojlovic on 24.12.24..
//

import Foundation
import XCTest
@testable import BITBrain

class MockUserDefaultsHelper: UserDefaultsHelper {

    private(set) var setUserToUserDefaultsCalled = false
    var emptyUserDefaultsCalled = false

    override func setUserToUserDefaults(user: UserModel) {
        setUserToUserDefaultsCalled = true
    }

    override func emptyUserDefaults() {
        emptyUserDefaultsCalled = true
    }
}
