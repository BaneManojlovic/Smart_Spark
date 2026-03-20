//
//  ProfileViewModelTests.swift
//  BITBrainTests
//
//  Created by Branislav Manojlovic on 27.12.24..
//

import XCTest
@testable import BITBrain

final class ProfileViewModelTests: XCTestCase {
    
    private var sut: ProfileViewModel!
    private var mockAuthService: MockAuthenticationManager!
    private var mockUserDefaultsHelper: MockUserDefaultsHelper!
    
    override func setUp() {
        super.setUp()
        mockAuthService = MockAuthenticationManager()
        mockUserDefaultsHelper = MockUserDefaultsHelper()
        sut = ProfileViewModel(authService: mockAuthService, userDefaultsHelper: mockUserDefaultsHelper)
    }
    
    override func tearDown() {
        sut = nil
        mockAuthService = nil
        mockUserDefaultsHelper = nil
        super.tearDown()
    }
    
    func test_fetchUserData_whenUserExists() {
        // Arrange
        let user = UserModel(id: UUID(), username: "John Doe", email: "john.doe@example.com", photoUrl: "image_path")
        mockUserDefaultsHelper.mockUser = user
        
        // Act
        sut.fetchUserData()
        
        // Assert
        XCTAssertEqual(sut.userModel?.username, "John Doe")
        XCTAssertEqual(sut.userModel?.email, "john.doe@example.com")
        XCTAssertEqual(sut.userModel?.photoUrl, "image_path")
    }
    
//    func test_downloadImage_success() async {
//        let user = UserModel(id: UUID(), username: "John Doe", email: "john.doe@example.com", photoUrl: "private/8D30873D-9467-4982-96F7-299C6755BEB9.png")
//        
//        if let uiImage = UIImage(named: "test_person_image"),
//           let imageData = uiImage.pngData() {
//            let image = AvatarImage(data: imageData)
//            mockAuthService.mockDownloadResult = image
//           
//            XCTAssertNotNil(image, "Expected AvatarImage to be initialized with valid image data.")
//            // Act
//            sut.fetchUserData()
//            sut.downloadImage(path: "private/8D30873D-9467-4982-96F7-299C6755BEB9.png")
//           
//            
//
//            // Assert
//            XCTAssertNotNil(sut.avatarImage)
//            XCTAssertEqual(sut.avatarImage?.data, imageData)
//            XCTAssertFalse(sut.isAvatarLoading)
//            XCTAssertTrue(mockAuthService.downloadImageCalled, "Expected downloadImage to be called.")
//        }
        // Arrange
//        let imageData = Data([0x00, 0x01, 0x02]) // Mocked image data
//        let image = AvatarImage(data: imageData)
//        mockAuthService.mockDownloadResult = image

       
//    }
    
    func test_fetchUserData_whenUserDoesNotExist() {
        // Arrange
        mockUserDefaultsHelper.mockUser = nil
        
        // Act
        sut.fetchUserData()
        
        // Assert
        XCTAssertNil(sut.userModel)
    }
    
    func test_downloadImage_success() async {
        // Arrange
        guard let uiImage = UIImage(systemName: "person.fill"),
           let imageData = uiImage.pngData() else { return } // Mocked image data
        let avatarImage = AvatarImage(data: imageData)
        mockAuthService.mockDownloadResult = avatarImage // Mock a successful image download
        
        let expectation = XCTestExpectation(description: "Download image completes")

        // Act
        Task {
            await sut.downloadImage(path: "private/8D30873D-9467-4982-96F7-299C6755BEB9.png")
            DispatchQueue.main.async {
                expectation.fulfill()
            }
        }
        
        // Wait for the downloadImage task to complete
        wait(for: [expectation], timeout: 2.0)

        // Assert
        XCTAssertNotNil(sut.avatarImage, "Expected avatarImage to be set.")
        XCTAssertEqual(sut.avatarImage?.data, imageData, "Expected avatarImage to have the correct data.")
        XCTAssertFalse(sut.isAvatarLoading, "Expected isAvatarLoading to be false after success.")
        XCTAssertTrue(mockAuthService.downloadImageCalled, "Expected downloadImage to be called.")
    }
    
    func test_downloadImage_fails() async {
        // Arrange
        mockAuthService.mockDownloadResult = nil
        
        let expectation = XCTestExpectation(description: "Download image completes")

        // Act
        Task {
            await sut.downloadImage(path: "private/8D30873D-9467-4982-96F7-299C6755BEB9.png")
            DispatchQueue.main.async {
                expectation.fulfill()
            }
        }
        
        // Wait for the downloadImage task to complete
        wait(for: [expectation], timeout: 2.0)
        // Assert
        
        XCTAssertNil(sut.avatarImage)
        XCTAssertTrue(mockAuthService.downloadImageCalled, "Expected downloadImage to be called.")
    }
    
    func test_deleteAccount_success() async {
        // Arrange
        let userId = UUID()
        sut.userModel = UserModel(id: userId, username: "John Doe", email: "john.doe@example.com", photoUrl: nil)
        mockAuthService.deleteUserSuccess = true
        
        let successExpectation = expectation(description: "Delete account success")
        let errorExpectation = expectation(description: "Delete account error")
        errorExpectation.isInverted = true
        
        // Act
        sut.deleteAccount(onSuccess: {
            successExpectation.fulfill()
        }, onError: {
            errorExpectation.fulfill()
        })
        
        // Wait
        wait(for: [successExpectation, errorExpectation], timeout: 2.0)
        
        // Assert
        XCTAssertNil(sut.userModel)
        XCTAssertTrue(mockAuthService.deleteUserCalled)
    }
    
    func test_deleteAccount_failure() async {
        // Arrange
        let userId = UUID()
        sut.userModel = UserModel(id: userId, username: "John Doe", email: "john.doe@example.com", photoUrl: nil)
        mockAuthService.deleteUserSuccess = false
        
        let successExpectation = expectation(description: "Delete account success")
        successExpectation.isInverted = true
        let errorExpectation = expectation(description: "Delete account error")
        
        // Act
        sut.deleteAccount(onSuccess: {
            successExpectation.fulfill()
        }, onError: {
            errorExpectation.fulfill()
        })
        
        // Wait
        wait(for: [successExpectation, errorExpectation], timeout: 2.0)
        
        // Assert
        XCTAssertNotNil(sut.userModel)
        XCTAssertTrue(mockAuthService.deleteUserCalled)
    }
    
    func test_deleteAccount_whenUserModelIsNil() async {
        // Arrange
        sut.userModel = nil // Simulate no user being logged in

        let successExpectation = expectation(description: "Delete account success")
        successExpectation.isInverted = true // This expectation should NOT be fulfilled
        let errorExpectation = expectation(description: "Delete account error")

        // Act
        sut.deleteAccount(onSuccess: {
            successExpectation.fulfill()
        }, onError: {
            errorExpectation.fulfill()
        })

        // Wait
        wait(for: [successExpectation, errorExpectation], timeout: 2.0)

        // Assert
        XCTAssertNil(sut.userModel, "Expected userModel to be nil.")
    }
    
    func test_saveProfile_success() async {
        // Arrange
        let userId = UUID()
        sut.userModel = UserModel(id: userId, username: "John Doe", email: "john.doe@example.com", photoUrl: nil)
        let imageData = Data([0x00, 0x01, 0x02])
        mockAuthService.mockUploadImageResult = "private/8D30873D-9467-4982-96F7-299C6755BEB9.png"
        
        // Act
        await sut.saveProfile(imageData: imageData)
        
        // Assert
        XCTAssertEqual(sut.userModel?.photoUrl, "private/8D30873D-9467-4982-96F7-299C6755BEB9.png")
        XCTAssertTrue(mockAuthService.uploadImageCalled)
    }

    func test_saveProfile_failure() async {
        // Arrange
        let userId = UUID()
        sut.userModel = UserModel(id: userId, username: "John Doe", email: "john.doe@example.com", photoUrl: nil)
        let imageData = Data([0x00, 0x01, 0x02])
        mockAuthService.mockUploadImageResult = nil
        
        // Act
        await sut.saveProfile(imageData: imageData)
        
        // Assert
        XCTAssertNotEqual(sut.userModel?.photoUrl, "new_image_url")
        XCTAssertTrue(mockAuthService.uploadImageCalled)
    }
    
    func test_saveProfile_whenUpdateUserDataFails() async {
        // Arrange
        let userId = UUID()
        sut.userModel = UserModel(id: userId, username: "John Doe", email: "john.doe@example.com", photoUrl: nil)
        let imageData = Data([0x00, 0x01, 0x02])
        let expectedError = NSError(domain: "MockErrorDomain", code: 123, userInfo: [NSLocalizedDescriptionKey: "Mock error"])
        mockAuthService.mockUpdateUserError = expectedError

        // Act
        await sut.saveProfile(imageData: imageData)

        // Assert
        XCTAssertTrue(mockAuthService.uploadImageCalled, "Expected uploadImage to be called.")
        XCTAssertEqual(mockAuthService.mockUpdateUserError?.localizedDescription, "Mock error", "Expected mock error to match.")
    }
}
