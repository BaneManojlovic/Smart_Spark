//
//  SplashScreenViewModel.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 31.10.24..
//

import Foundation
import FirebaseAuth

class SplashScreenViewModel: ObservableObject {
    
    let authService = AuthenticationManager()
    
    func checkForUser() -> UserModel? {
        do {
            let user = try authService.getAuthenticatedUser()
            print("user exists")
            return user
        } catch {
            print("no user")
            return nil
        }
    }
}
