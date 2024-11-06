//
//  ChatTabViewModel.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 25.10.24..
//

import Foundation

final class ChatNavigationViewModel: ObservableObject {
    
    @Published var coordinator: ChatCoordinator
    
    init(coordinator: ChatCoordinator) {
        self.coordinator = coordinator
    }
}
