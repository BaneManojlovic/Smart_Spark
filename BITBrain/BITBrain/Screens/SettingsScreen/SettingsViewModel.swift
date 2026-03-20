//
//  SettingsViewModel.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 31.10.24..
//

import Foundation

class SettingsViewModel: ObservableObject {

    // MARK: - Properties

    var authService: AuthenticationManagerProtocol
    var userDefaultsHelper: UserDefaultsHelperProtocol

    // MARK: - Init

    init(authService: AuthenticationManagerProtocol = AuthenticationManager.shared,
         userDefaultsHelper: UserDefaultsHelperProtocol = UserDefaultsHelper()) {
        self.authService = authService
        self.userDefaultsHelper = userDefaultsHelper
    }

    // MARK: - Methods

    func logout() async {
        await authService.signOut()
        userDefaultsHelper.emptyUserDefaults()
    }
}
