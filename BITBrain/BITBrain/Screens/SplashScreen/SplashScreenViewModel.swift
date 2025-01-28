//
//  SplashScreenViewModel.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 31.10.24..
//

import Foundation
import Supabase

class SplashScreenViewModel: ObservableObject {

    var authManager = AuthenticationManager.shared
    
    func isUserLoggedIn() async -> Bool {
        if let userId = await authManager.getAuthenticatedUser(), !userId.uuidString.isEmpty {
            return true
        } else {
            return false
        }
    }
}
