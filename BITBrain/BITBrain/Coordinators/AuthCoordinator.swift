//
//  AuthCoordinator.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 25.10.24..
//

import Foundation
import SwiftUI

final class AuthCoordinator: ObservableObject {
    
    @Published var path: [AuthDestinations] = []

    func goBack() {
        guard !path.isEmpty else {
            print("Warning: Attempted to go back, but the path is empty.")
            return
        }
        path.removeLast()
    }

    func navigateToRegistration() {
        path.append(AuthDestinations.register)
    }
}

extension AuthCoordinator: Coordinator {
   
    @ViewBuilder
    func redirect(_ path: AuthDestinations) -> some View {
        switch path {
        case .register:
            let viewModel = AuthNavigationViewModel(coordinator: self)
            RegistrationView(authNavViewModel: viewModel)
        }
    }
    
}
