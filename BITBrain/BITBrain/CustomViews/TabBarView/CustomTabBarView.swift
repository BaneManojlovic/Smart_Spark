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
                    HomeView(chatController: chatController)
                        .tabItem {
                            Image(systemName: "house.fill")
                            Text("Home")
                        }
                    SettingsView(settingsNavViewModel: SettingsNavigationViewModel(coordinator: settingsCoordinator))
                        .tabItem {
                            Image(systemName: "gear")
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
