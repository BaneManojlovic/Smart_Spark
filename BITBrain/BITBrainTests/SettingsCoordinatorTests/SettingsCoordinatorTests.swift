//
//  SettingsCoordinatorTests.swift
//  BITBrainTests
//
//  Created by Branislav Manojlovic on 30.12.24..
//

import XCTest
import ViewInspector
@testable import BITBrain


final class SettingsCoordinatorTests: XCTestCase {

    private var coordinator: SettingsCoordinator!

    override func setUp() {
        super.setUp()
        coordinator = SettingsCoordinator()
    }

    override func tearDown() {
        coordinator = nil
        super.tearDown()
    }

    // MARK: - Navigation Tests

    func testNavigateToProfile() {
        // Act
        coordinator.navigateToProfile()

        // Assert
        XCTAssertEqual(coordinator.path.count, 1, "Expected path to contain one destination.")
        XCTAssertEqual(coordinator.path.last, .profile, "Expected last destination to be .profile.")
    }

    func testNavigateToThreadArchive() {
        // Act
        coordinator.navigateToThreadArchive()

        // Assert
        XCTAssertEqual(coordinator.path.count, 1, "Expected path to contain one destination.")
        XCTAssertEqual(coordinator.path.last, .threadArchive, "Expected last destination to be .threadArchive.")
    }

    func testNavigateToPrivacyPolicy() {
        // Act
        coordinator.navigateToPrivacyPolicy()

        // Assert
        XCTAssertEqual(coordinator.path.count, 1, "Expected path to contain one destination.")
        XCTAssertEqual(coordinator.path.last, .privacyPolicy, "Expected last destination to be .privacyPolicy.")
    }

    // MARK: - Back Navigation Tests

    func testGoBack() {
        // Arrange
        coordinator.navigateToProfile()
        coordinator.navigateToThreadArchive()

        // Act
        coordinator.goBack()

        // Assert
        XCTAssertEqual(coordinator.path.count, 1, "Expected path to contain one destination after goBack.")
        XCTAssertEqual(coordinator.path.last, .profile, "Expected last destination to be .profile after goBack.")
    }

    func testGoBackWhenPathIsEmpty() {
        // Act
        coordinator.goBack()

        // Assert
        XCTAssertEqual(coordinator.path.count, 0, "Expected path to remain empty after goBack when path is empty.")
    }

    // MARK: - Redirect Tests

    func testRedirectProfile() throws {
        // Act
        let view = coordinator.redirect(.profile)

        // Assert
        let inspectedView = try view.inspect().anyView().view(ProfileView.self)
        XCTAssertNotNil(inspectedView, "Expected redirect to return ProfileView for .profile.")
    }

    func testRedirectThreadArchive() throws {
        // Act
        let view = coordinator.redirect(.threadArchive)

        // Assert
        let inspectedView = try view.inspect().anyView().view(ThreadArchiveView.self)
        XCTAssertNotNil(inspectedView, "Expected redirect to return ThreadArchiveView for .threadArchive.")
    }

    func testRedirectPrivacyPolicy() throws {
        // Act
        let view = coordinator.redirect(.privacyPolicy)

        // Assert
        let inspectedView = try view.inspect().anyView().view(PrivacyPolicyView.self)
        XCTAssertNotNil(inspectedView, "Expected redirect to return PrivacyPolicyView for .privacyPolicy.")
    }
}
