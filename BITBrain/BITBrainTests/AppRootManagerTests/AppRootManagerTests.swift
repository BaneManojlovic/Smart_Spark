//
//  AppRootManagerTests.swift
//  BITBrainTests
//
//  Created by Branislav Manojlovic on 27.12.24..
//

import XCTest
@testable import BITBrain

final class AppRootManagerTests: XCTestCase {
    
    func test_initialState_isSplash() {
        // Arrange
        let appRootManager = AppRootManager()
        // Act
        let initialRoot = appRootManager.currentRoot
        // Assert
        XCTAssertEqual(initialRoot, .splash, "The initial state of currentRoot should be .splash.")
    }

    func test_currentRoot_canBeSetToAuthentication() {
        // Arrange
        let appRootManager = AppRootManager()
        // Act
        appRootManager.currentRoot = .authentication
        // Assert
        XCTAssertEqual(appRootManager.currentRoot, .authentication, "currentRoot should be set to .authentication.")
    }

    func test_currentRoot_canBeSetToHome() {
        // Arrange
        let appRootManager = AppRootManager()
        // Act
        appRootManager.currentRoot = .home
        // Assert
        XCTAssertEqual(appRootManager.currentRoot, .home, "currentRoot should be set to .home.")
    }

    func test_appRootManagerDeallocation() {
        // Arrange
        weak var weakAppRootManager: AppRootManager?
        // Act
        do {
            let appRootManager = AppRootManager()
            weakAppRootManager = appRootManager
            // Perform operations if needed to simulate usage
        }
        // Assert
        XCTAssertNil(weakAppRootManager, "AppRootManager should have been deallocated.")
    }

    func test_protocolConformance() {
        // Arrange
        let appRootManager: AppRootManaging = AppRootManager()
        // Act & Assert
        XCTAssertEqual(appRootManager.currentRoot, .splash, "AppRootManager should conform to AppRootManaging and have an initial state of .splash.")
    }
}
