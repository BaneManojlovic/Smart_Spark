//
//  ChatCoordinator.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 25.10.24..
//

import Foundation
import SwiftUI

final class ChatCoordinator: ObservableObject {
    
    @Published var path: [ChatDestination] = []
    
    func goBack() {
        path.removeLast()
    }

    func navigateToRecentThreads() {
        path.append(ChatDestination.recentThreads)
    }
}

extension ChatCoordinator: Coordinator {
    
    @ViewBuilder
    func redirect(_ path: ChatDestination) -> some View {
        switch path {
        case .recentThreads:
            let viewModel = ChatNavigationViewModel(coordinator: self)
            RecentThreadsView(chatNavViewModel: viewModel)
                .toolbar(.hidden, for: .tabBar)
        }
    }
}
