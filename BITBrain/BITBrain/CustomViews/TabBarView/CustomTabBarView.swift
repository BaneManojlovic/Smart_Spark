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
        
        ZStack(alignment: .bottom) {
            
            TabView {
                Group {
                    ChatView(chatController: chatController)
                        .tabItem {
                            Image(systemName: "bubble.left.and.text.bubble.right.fill")
                            Text("Chat")
                        }
                    SettingsView(settingsNavViewModel: SettingsNavigationViewModel(coordinator: settingsCoordinator))
                        .tabItem {
                            Image(systemName: "gearshape.2")
                            Text("Settings")
                        }
                }
                .clipShape(Rectangle())
                .background(Color.white)
                .toolbarBackground(.white, for: .tabBar)
                .toolbarBackground(.visible, for: .tabBar)
                
            }
            .tint(.darkYellow)
            
            
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.lightGrayBit) // Border color
                .edgesIgnoringSafeArea(.bottom)
                .offset(y: -49)
        }
    }
}

//#Preview {
//    CustomTabBarView()
//}
//.border(Color.primaryBlue, width: 2.0)
