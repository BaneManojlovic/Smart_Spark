//
//  SettingsViewModel.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 31.10.24..
//

import Foundation

class SettingsViewModel: ObservableObject {

    let authService = AuthenticationManager()
    let userDefaultsHelper = UserDefaultsHelper()

    func logout() throws {
        try authService.signOut()
        userDefaultsHelper.emptyUserDefaults()
    }
}
