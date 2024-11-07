//
//  CustomTabBarView.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 22.10.24..
//

import SwiftUI

struct CustomTabBarView: View {
    
    @StateObject var chatCoordinator = ChatCoordinator()
    @StateObject var settingsCoordinator = SettingsCoordinator()

    var body: some View {
        TabView {
            Group {
                ChatView(chatNavViewModel: ChatNavigationViewModel(coordinator: chatCoordinator))
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
