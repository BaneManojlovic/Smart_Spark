//
//  RegistrationViewModelTests.swift
//  BITBrainTests
//
//  Created by Branislav Manojlovic on 23.12.24..
//

import XCTest
@testable import BITBrain

final class RegistrationViewModelTests: XCTestCase {

    // SUT - System Under Test
    private var sut: RegistrationViewModel!
    private var mockAuthService: MockAuthenticationManager!
    private var mockUserDefaultsHelper: MockUserDefaultsHelper!

    override func setUp() {
        super.setUp()
        mockAuthService = MockAuthenticationManager()
        mockUserDefaultsHelper = MockUserDefaultsHelper()
        sut = RegistrationViewModel(authService: mockAuthService, userDefaultsHelper: mockUserDefaultsHelper)
    }

    override func tearDown() {
        sut = nil
        mockAuthService = nil
        mockUserDefaultsHelper = nil
        super.tearDown()
    }

    private func setValidRegistrationData() {
        sut.username = "John Doe"
        sut.emailText = "john.doe@example.com"
        sut.passwordText = "Password123"
        sut.repeatedPasswordText = "Password123"
    }

    private func setInvalidPasswords() {
        sut.passwordText = "Password123"
        sut.repeatedPasswordText = "Password456" // Different password
    }
    
    // MARK: - Tests

    func test_registerAction_successfulRegistration() {
        // Arrange
        setValidRegistrationData()
        mockAuthService.registerShouldSucceed = true

        let expectation = self.expectation(description: "Registration should complete")

        // Act
        sut.registerUser { success in
            // Assert
            XCTAssertTrue(success)
            XCTAssertFalse(self.sut.isLoading)
            XCTAssertNil(self.sut.alertMessage)
            XCTAssertTrue(self.mockAuthService.wasRegisterCalled())
            XCTAssertTrue(self.mockUserDefaultsHelper.setUserToUserDefaultsCalled)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func test_registerAction_passwordsDoNotMatch() {
        // Arrange
        setInvalidPasswords()
        let expectation = self.expectation(description: "Registration should fail due to mismatched passwords")

        // Act
        sut.registerUser { success in
            // Assert
            XCTAssertFalse(success)
            XCTAssertFalse(self.sut.isLoading)
            XCTAssertEqual(self.sut.alertMessage?.message, "Passwords do not match.")
            XCTAssertFalse(self.mockAuthService.wasRegisterCalled())
            XCTAssertFalse(self.mockUserDefaultsHelper.setUserToUserDefaultsCalled)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func test_registerAction_registrationFails() {
        // Arrange
        setValidRegistrationData()
        mockAuthService.registerShouldSucceed = false // Simulate backend failure

        let expectation = self.expectation(description: "Registration should fail due to backend failure")

        // Act
        sut.registerUser { success in
            // Assert
            XCTAssertFalse(success)
            XCTAssertFalse(self.sut.isLoading)
            XCTAssertEqual(self.sut.alertMessage?.message, "Registration failed, please try again.")
            XCTAssertTrue(self.mockAuthService.wasRegisterCalled())
            XCTAssertFalse(self.mockUserDefaultsHelper.setUserToUserDefaultsCalled)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }

    func test_registerNewUser_success() async {
        // Arrange
        mockAuthService.registerShouldSucceed = true

        // Act
        let userId = await sut.registerNewUser(email: "test@example.com", password: "Password123")

        // Assert
        XCTAssertNotNil(userId)
        XCTAssertTrue(mockAuthService.wasRegisterCalled())
    }

    func test_saveUserData_callsUserDefaults() {
        // Arrange
        let user = UserModel(id: UUID(), username: "John Doe", email: "john.doe@example.com", photoUrl: nil)

        // Act
        sut.saveUserData(user: user)

        // Assert
        XCTAssertTrue(mockUserDefaultsHelper.setUserToUserDefaultsCalled)
    }

    func test_saveUserDataToDatabase_callsAuthService() async {
        // Arrange
        let user = UserModel(id: UUID(), username: "John Doe", email: "john.doe@example.com", photoUrl: nil)
        let taskCompletion = expectation(description: "Task completed")

        // Act
        sut.saveUserDataToDatabase(user: user) {
            taskCompletion.fulfill()
        }

        await fulfillment(of: [taskCompletion], timeout: 1.0)

        // Assert
        XCTAssertTrue(mockAuthService.wasSaveUserToDatabaseCalled())
    }

    func test_saveUserDataToDatabase_handlesError() async {
        // Arrange
        let user = UserModel(id: UUID(), username: "John Doe", email: "john.doe@example.com", photoUrl: nil)
        let simulatedError = NSError(domain: "MockErrorDomain", code: 123, userInfo: [NSLocalizedDescriptionKey: "Mock error occurred"])
        mockAuthService.simulateSaveError = simulatedError

        let taskCompletion = expectation(description: "Task completed")

        // Act
        sut.saveUserDataToDatabase(user: user) {
            taskCompletion.fulfill()
        }
        

        await fulfillment(of: [taskCompletion], timeout: 1.0)

        // Assert
        XCTAssertTrue(mockAuthService.wasSaveUserToDatabaseCalled())
    }
}
