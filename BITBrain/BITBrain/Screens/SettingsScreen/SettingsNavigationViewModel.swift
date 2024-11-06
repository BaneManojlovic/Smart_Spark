//
//  ProfileNavigationViewModel.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 29.10.24..
//

import Foundation

final class SettingsNavigationViewModel: ObservableObject {
    
    @Published var coordinator: SettingsCoordinator

    init(coordinator: SettingsCoordinator) {
        self.coordinator = coordinator
    }
}
