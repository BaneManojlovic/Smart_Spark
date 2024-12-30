//
//  AuthCoordinatorTests.swift
//  BITBrainTests
//
//  Created by Branislav Manojlovic on 30.12.24..
//

import XCTest
import ViewInspector
@testable import BITBrain

final class AuthCoordinatorTests: XCTestCase {
    
    func testGoBack_whenPathIsNotEmpty() {
        let coordinator = AuthCoordinator()
        coordinator.path = [.register]
        coordinator.goBack()
        XCTAssertTrue(coordinator.path.isEmpty, "Expected path to be empty after going back.")
    }

    func testGoBack_whenPathIsEmpty() {
        let coordinator = AuthCoordinator()
        coordinator.goBack()
        XCTAssertTrue(coordinator.path.isEmpty, "Expected path to remain empty when going back with an empty path.")
    }

    func testNavigateToRegistration() {
        let coordinator = AuthCoordinator()
        coordinator.navigateToRegistration()
        XCTAssertEqual(coordinator.path, [.register], "Expected path to contain `.register` after navigation.")
    }

    func testRedirect_toRegister() throws {
        let coordinator = AuthCoordinator()
        let view = coordinator.redirect(.register)
        XCTAssertNotNil(view, "Expected redirect to return RegistrationView for .register.")
    }
}
