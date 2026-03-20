//
//  SettingsViewModelTests.swift
//  BITBrainTests
//
//  Created by Branislav Manojlovic on 26.12.24..
//


import XCTest
@testable import BITBrain

final class SettingsViewModelTests: XCTestCase {
    
    private var sut: SettingsViewModel! // System Under Test
    private var mockAuthService: MockAuthenticationManager!
    private var mockUserDefaultsHelper: MockUserDefaultsHelper!
    
    override func setUp() {
        super.setUp()
        mockAuthService = MockAuthenticationManager()
        mockUserDefaultsHelper = MockUserDefaultsHelper()
        sut = SettingsViewModel(authService: mockAuthService, userDefaultsHelper: mockUserDefaultsHelper)
    }
    
    override func tearDown() {
        sut = nil
        mockAuthService = nil
        mockUserDefaultsHelper = nil
        super.tearDown()
    }
    
    func test_logout_callsSignOutAndEmptyUserDefaults() async {
        // Act
        await sut.logout()
        
        // Assert
        XCTAssertTrue(mockAuthService.signOutCalled, "Expected signOut to be called on AuthenticationManager.")
        XCTAssertTrue(mockUserDefaultsHelper.emptyUserDefaultsCalled, "Expected emptyUserDefaults to be called on UserDefaultsHelper.")
    }
    
}
