//
//  ProfileViewModel.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 14.11.24..
//

import Foundation

class ProfileViewModel: ObservableObject {
    
    let userDefaultsHelper = UserDefaultsHelper()
    
    func showUserData() -> String {
        if let user = userDefaultsHelper.getUser() {
            return "\(user.email ?? "")"
        } else {
            return "--"
        }
        
    }
}
