//
//  AppState.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 26.10.24..
//

import Foundation
import SwiftUI

class AppState: ObservableObject {
    
    @Published var apiKeyValue: String = "" {
        didSet {
            // Update ChatController when API key changes
            chatController.setApiToken(apiKeyValue)
        }
    }
    
    let chatController: ChatController
    
    init() {
        // Initialize ChatController with default or stored API key
        let storedApiKey = UserDefaults.standard.string(forKey: "openAIAPIToken") ?? ""
        self.apiKeyValue = storedApiKey
        self.chatController = ChatController(apiToken: storedApiKey)
    }
    
    func clearApiKey() {
        apiKeyValue = ""
        UserDefaults.standard.removeObject(forKey: "openAIAPIToken")
    }
    
    func saveApiKey(_ key: String) {
        apiKeyValue = key
        UserDefaults.standard.setValue(key, forKey: "openAIAPIToken")
    }
}
