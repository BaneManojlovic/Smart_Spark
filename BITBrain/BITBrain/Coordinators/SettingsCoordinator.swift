//
//  SettingsCoordinator.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 25.10.24..
//

import Foundation
import SwiftUI

final class SettingsCoordinator: ObservableObject {
    
    @Published var path: [SettingsDestinations] = []
    
    func goBack() {
        path.removeLast()
    }
    
    func navigateToProfile() {
        path.append(SettingsDestinations.profile)
    }
    
    func navigateToThreadArchive() {
        path.append(SettingsDestinations.threadArchive)
    }
    
    func navigateToPrivacyPolicy() {
        path.append(SettingsDestinations.privacyPolicy)
    }
}

extension SettingsCoordinator: Coordinator {
    
    @ViewBuilder
    func redirect(_ path: SettingsDestinations) -> some View {
        let viewModel = SettingsNavigationViewModel(coordinator: self)
        switch path {
        case .profile:
            ProfileView(settingsNavViewModel: viewModel)
        case .privacyPolicy:
            PrivacyPolicyView(settingsNavViewModel: viewModel)
        case .threadArchive:
            ThreadArchiveView(settingsNavViewModel: viewModel)
        }
    }
}
