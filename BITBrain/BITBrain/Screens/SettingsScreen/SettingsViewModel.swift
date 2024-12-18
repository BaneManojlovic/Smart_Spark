//
//  SettingsViewModel.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 31.10.24..
//

import Foundation

class SettingsViewModel: ObservableObject {

    let authService = AuthenticationManager.shared
    let userDefaultsHelper = UserDefaultsHelper()

    func logout() async {
        await authService.signOut()
        userDefaultsHelper.emptyUserDefaults()
    }
}
