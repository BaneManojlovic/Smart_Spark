//
//  SplashViewModel.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 25.10.24..
//

import Foundation

final class AuthNavigationViewModel: ObservableObject {
    
    @Published var coordinator: AuthCoordinator
    
    init(coordinator: AuthCoordinator) {
        self.coordinator = coordinator
    }
}
