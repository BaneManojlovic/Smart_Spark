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

    func test_loginUser_successfulLogin() {
        // Arrange
        let mockUserId = UUID() // Simulate a valid user ID
        let mockUser = UserModel(id: mockUserId, username: "John Doe", email: "john.doe@example.com", photoUrl: nil)

        mockAuthService.loginShouldSucceed = true // Simulate successful login
        mockAuthService.simulatedUserId = mockUserId // Simulate a valid user ID
        mockAuthService.simulatedUserData = mockUser // Simulate user data returned from the database

        let expectation = self.expectation(description: "Login should succeed")


        // Act
        sut.loginUser { success in
            // Assert
            XCTAssertTrue(success, "Expected login to succeed, but it failed.")
            XCTAssertTrue(self.mockAuthService.wasLoginCalled(), "Expected login method to be called on MockAuthenticationManager.")
            expectation.fulfill()
        }

        // Wait for asynchronous operations to complete
        wait(for: [expectation], timeout: 2.0)
    }
    
    func test_mockLogin() async {
        mockAuthService.loginShouldSucceed = true
        let result = await mockAuthService.login(email: "john.doe@example.com", password: "password123")
        XCTAssertTrue(result)
        XCTAssertTrue(mockAuthService.wasLoginCalled())
    }

    func test_loginAction_loginFails() {
        // Arrange
        mockAuthService.loginShouldSucceed = false

        let expectation = self.expectation(description: "Login should fail")

        // Act
        sut.loginUser { success in
            // Assert
            XCTAssertFalse(success)
            XCTAssertTrue(self.mockAuthService.wasLoginCalled())
            XCTAssertFalse(self.mockUserDefaultsHelper.setUserToUserDefaultsCalled)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func test_saveUserData_savesToUserDefaults() {
        // Arrange
        let user = UserModel(id: UUID(), username: "John Doe", email: "john.doe@example.com", photoUrl: nil)

        // Act
        sut.saveUserData(user: user)

        // Assert
        XCTAssertTrue(mockUserDefaultsHelper.setUserToUserDefaultsCalled)
    }
}
