//
//  SplashScreenViewModel.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 31.10.24..
//

import Foundation
import Supabase

class SplashScreenViewModel: ObservableObject {

    let authManager = AuthenticationManager.shared
    
    func checkForUser() async -> UserModel? {
        do {
            let user = await authManager.getAuthenticatedUser()
            return user
        }
    }
}
