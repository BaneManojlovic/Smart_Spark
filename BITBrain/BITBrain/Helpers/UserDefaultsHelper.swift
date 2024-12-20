//
//  UserDefaultsHelper.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 13.11.24..
//

import Foundation

enum UserDefaultKeys: String {
    case user
}

class UserDefaultsHelper: ObservableObject {
    
    private let openAiAPIToken = "openAiAPIToken"
    
    // Published property to notify SwiftUI views
    @Published var apiToken: String? {
        didSet {
            // Save to UserDefaults whenever the apiToken changes
            if let token = apiToken {
                UserDefaults.standard.set(token, forKey: openAiAPIToken)
            } else {
                UserDefaults.standard.removeObject(forKey: openAiAPIToken)
            }
        }
    }
    
    // MARK: - Initializer
    init() {
        // Load initial value from UserDefaults
        self.apiToken = UserDefaults.standard.string(forKey: openAiAPIToken)
    }
    
    // MARK: - UserDefaults methods for hadling UserModel
    
    func setUserToUserDefaults(user: UserModel) {
        do {
            let userData = try JSONEncoder().encode(user)
            UserDefaults.standard.set(userData, forKey: UserDefaultKeys.user.rawValue)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }

    func getUserFromUserDefaults() -> UserModel? {
        do {
            guard let userData = UserDefaults.standard.data(forKey: UserDefaultKeys.user.rawValue) else {
                return nil
            }
            let user = try JSONDecoder().decode(UserModel.self, from: userData)
            return user
        } catch {
            debugPrint(error.localizedDescription)
            return nil
        }
    }

    func removeUserFromUserDefaults() {
        UserDefaults.standard.removeObject(forKey: UserDefaultKeys.user.rawValue)
    }

    // MARK: - Methods for handling openAI apiToken

    func setOpenAiAPIToken(_ apiToken: String) {
        UserDefaults.standard.set(apiToken, forKey: openAiAPIToken)
    }
    
    func getOpenAiAPIToken() -> String? {
        return UserDefaults.standard.string(forKey: openAiAPIToken)
    }
    
    func removeOpenAiAPIToken() {
        UserDefaults.standard.removeObject(forKey: openAiAPIToken)
    }

    // MARK: - Method for emptying user defaults

    func emptyUserDefaults() {
        self.removeUserFromUserDefaults()
        self.removeOpenAiAPIToken()
    }
}
