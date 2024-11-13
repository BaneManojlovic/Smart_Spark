//
//  CustomTabBarView.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 22.10.24..
//

import SwiftUI

struct CustomTabBarView: View {

    @StateObject var settingsCoordinator = SettingsCoordinator()
    @StateObject var chatController = ChatController(apiToken: "")

    var body: some View {
        TabView {
            Group {
                ChatView(chatController: chatController)
                    .tabItem {
                        Image(systemName: "message")
                        Text("Chat")
                    }
                SettingsView(settingsNavViewModel: SettingsNavigationViewModel(coordinator: settingsCoordinator))
                    .tabItem {
                        Image(systemName: "gearshape")
                        Text("Settings")
                    }
            }
            .toolbarBackground(.primaryBlue, for: .tabBar)
            .toolbarBackground(.visible, for: .tabBar)

        }
        .tint(.darkYellow)
    }
}

//#Preview {
//    CustomTabBarView()
//}
