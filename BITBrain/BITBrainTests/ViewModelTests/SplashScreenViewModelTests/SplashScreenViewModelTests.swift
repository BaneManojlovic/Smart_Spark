//
//  SplashScreenViewModelTests.swift
//  BITBrainTests
//
//  Created by Branislav Manojlovic on 24.12.24..
//

import Foundation
import XCTest
import SwiftUI
import ViewInspector
@testable import BITBrain

final class SplashScreenViewModelTests: XCTestCase {
    
    // SUT - System Under Test
    private var sut: SplashScreenViewModel!
    private var mockAuthManager: MockAuthenticationManager!
    
    override func setUp() {
        super.setUp()
        mockAuthManager = MockAuthenticationManager()
        sut = SplashScreenViewModel()
        sut.authManager = mockAuthManager // Inject the mock
    }
    
    override func tearDown() {
        sut = nil
        mockAuthManager = nil
        super.tearDown()
    }
    
    func test_checkForUser_returnsTrueWhenUserExists() async {
        // Arrange
        mockAuthManager.simulatedUserId = UUID() // Simulate valid user ID

        // Act
        let result = await sut.isUserLoggedIn()

        // Assert
        XCTAssertEqual(result, true, "Expected checkForUser to return true when a valid user exists.")
    }
    
    func test_checkForUser_returnsFalseWhenNoUserExists() async {
        // Arrange
        mockAuthManager.simulatedUserId = nil // Simulate no user

        // Act
        let result = await sut.isUserLoggedIn()

        // Assert
        XCTAssertEqual(result, false, "Expected checkForUser to return false when no user exists.")
    }
    
    func test_checkForUser_returnsFalseWhenUserIdIsEmpty() async {
        // Arrange
        mockAuthManager.simulatedUserId = UUID(uuidString: "") // Simulate invalid user ID

        // Act
        let result = await sut.isUserLoggedIn()

        // Assert
        XCTAssertEqual(result, false, "Expected checkForUser to return false when the user ID is empty.")
    }
    
    func test_rootChangesAfterDelay_toHome() {
        // Arrange
        let mockAppRootManager = MockAppRootManager()
        let mockViewModel = SplashScreenViewModel()
        let splashScreenView = SplashScreenView(viewModel: mockViewModel)
            .environmentObject(mockAppRootManager)

        let expectation = self.expectation(description: "Wait for root change")
        
        // Simulate the logged-in state
        Task {
            mockViewModel.authManager = MockAuthenticationManager()
            (mockViewModel.authManager as? MockAuthenticationManager)?.simulatedUserId = UUID() // Simulate user is logged in
            let isLoggedIn = await mockViewModel.isUserLoggedIn()
            
            // Act
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                // Update the root based on the simulated `isLoggedIn` state
                mockAppRootManager.currentRoot = isLoggedIn ? .home : .authentication
                
                // Assert
                XCTAssertEqual(mockAppRootManager.currentRoot, .home)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 3.0)
    }
    
    func test_rootChangesAfterDelay_toAuthentication() {
        // Arrange
        let mockAppRootManager = MockAppRootManager()
        let mockViewModel = SplashScreenViewModel()
        let splashScreenView = SplashScreenView(viewModel: mockViewModel)
            .environmentObject(mockAppRootManager)

        let expectation = self.expectation(description: "Wait for root change")
        
        // Simulate the logged-in state
        Task {
            mockViewModel.authManager = MockAuthenticationManager()
            (mockViewModel.authManager as? MockAuthenticationManager)?.simulatedUserId = nil // Simulate user is logged in
            let isLoggedIn = await mockViewModel.isUserLoggedIn()
            
            // Act
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                // Update the root based on the simulated `isLoggedIn` state
                mockAppRootManager.currentRoot = isLoggedIn ? .home : .authentication
                
                // Assert
                XCTAssertEqual(mockAppRootManager.currentRoot, .authentication)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 3.0)
    }
}

class MockAppRootManager: AppRootManaging, ObservableObject {
    var currentRoot: AppRootManager.AppRoot = .authentication // Default state
}
