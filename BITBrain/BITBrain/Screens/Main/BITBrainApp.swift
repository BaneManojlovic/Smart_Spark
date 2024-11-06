//
//  BITBrainApp.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 21.10.24..
//

import SwiftUI

@main
struct BITBrainApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject private var appRootManager = AppRootManager()
    
    var body: some Scene {
        WindowGroup {
            Group {
                switch appRootManager.currentRoot {
                case .splash:
                    SplashScreenView()
                        .background(.black)
                case .authentication:
                    LoginView(authNavViewModel: AuthNavigationViewModel(coordinator: AuthCoordinator()) )
                case .home:
                    ContentView()
                }
            }
            .environmentObject(appRootManager)
            
            
        }
    }
}
