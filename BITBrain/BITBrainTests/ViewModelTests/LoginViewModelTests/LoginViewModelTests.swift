//
//  LoginViewModelTests.swift
//  BITBrainTests
//
//  Created by Branislav Manojlovic on 24.12.24..
//

import XCTest
@testable import BITBrain

final class LoginViewModelTests: XCTestCase {

    private var sut: LoginViewModel!
    private var mockAuthService: MockAuthenticationManager!
    private var mockUserDefaultsHelper: MockUserDefaultsHelper!

    override func setUp() {
        super.setUp()
        mockAuthService = MockAuthenticationManager()
        mockUserDefaultsHelper = MockUserDefaultsHelper()
        sut = LoginViewModel()
        sut.authService = mockAuthService
        sut.userDefaultsHelper = mockUserDefaultsHelper
    }

    override func tearDown() {
        sut = nil
        mockAuthService = nil
        mockUserDefaultsHelper = nil
        super.tearDown()
    }

    func test_loginAction_successfulLogin() {
        // Arrange
        mockAuthService.loginShouldSucceed = true
        mockAuthService.simulatedUserId = UUID()
        mockAuthService.simulatedUserData = UserModel(id: mockAuthService.simulatedUserId!, username: "John Doe", email: "john.doe@example.com", photoUrl: nil)

        let expectation = self.expectation(description: "Login should succeed")

        // Act
        sut.loginAction { success in
            // Assert
            XCTAssertTrue(success)
            XCTAssertTrue(self.mockAuthService.wasLoginCalled())
            XCTAssertTrue(self.mockAuthService.wasGetUserDataFromDatabaseCalled())
            XCTAssertTrue(self.mockUserDefaultsHelper.setUserToUserDefaultsCalled)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func test_loginAction_loginFails() {
        // Arrange
        mockAuthService.loginShouldSucceed = false

        let expectation = self.expectation(description: "Login should fail")

        // Act
        sut.loginAction { success in
            // Assert
            XCTAssertFalse(success)
            XCTAssertTrue(self.mockAuthService.wasLoginCalled())
            XCTAssertFalse(self.mockAuthService.wasGetUserDataFromDatabaseCalled())
            XCTAssertFalse(self.mockUserDefaultsHelper.setUserToUserDefaultsCalled)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func test_getUserDataFromDatabase_fetchesAndSavesUserData() async {
        // Arrange
        let userId = UUID()
        let simulatedUser = UserModel(id: userId, username: "Jane Doe", email: "jane.doe@example.com", photoUrl: nil)
        mockAuthService.simulatedUserData = simulatedUser

        // Act
        let user = await sut.getUserDataFromDatabase(userId: userId)

        // Assert
        XCTAssertNotNil(user)
        XCTAssertEqual(user?.id, userId)
        XCTAssertTrue(mockAuthService.wasGetUserDataFromDatabaseCalled())
        XCTAssertTrue(mockUserDefaultsHelper.setUserToUserDefaultsCalled)
    }

    func test_saveUserData_savesToUserDefaults() {
        // Arrange
        let user = UserModel(id: UUID(), username: "John Doe", email: "john.doe@example.com", photoUrl: nil)

        // Act
        sut.saveUserData(user: user)

        // Assert
        XCTAssertTrue(mockUserDefaultsHelper.setUserToUserDefaultsCalled)
    }
    
    func test_getUserDataFromDatabase_returnsNilWhenUserNotFound() async {
        // Arrange
        let userId = UUID()
        mockAuthService.simulatedUserData = nil // Simulate user not found

        // Act
        let user = await sut.getUserDataFromDatabase(userId: userId)

        // Assert
        XCTAssertNil(user) // Verify that the method returns nil
        XCTAssertTrue(mockAuthService.wasGetUserDataFromDatabaseCalled()) // Ensure the API call was made
        XCTAssertFalse(mockUserDefaultsHelper.setUserToUserDefaultsCalled) // Ensure no user data was saved
    }
}
