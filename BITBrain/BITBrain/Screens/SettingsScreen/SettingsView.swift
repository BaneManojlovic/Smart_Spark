//
//  SettingsView.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 22.10.24..
//

import SwiftUI

struct SettingsView: View {
    
    @EnvironmentObject private var appRootManager: AppRootManager
    @ObservedObject var settingsNavViewModel: SettingsNavigationViewModel
    @ObservedObject var viewModel = SettingsViewModel()
    
    let settingsItems = [
        SettingsItem(title: "Profile", iconName: "person"),
        SettingsItem(title: "Thread Archive", iconName: "message"),
        SettingsItem(title: "Privacy Policy", iconName: "lock"),
        SettingsItem(title: "Rate", iconName: "star"),
        SettingsItem(title: "Share", iconName: "square.and.arrow.up"),
        SettingsItem(title: "Logout", iconName: "power")
    ]
    
    @StateObject var alertViewModel = AlertViewModel()

    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                    LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                        ForEach(settingsItems) { item in
                            SettingsViewCell(item: item, alertViewModel: alertViewModel, viewModel: settingsNavViewModel)
                                .frame(height: 180)
                                .cornerRadius(10)
                        }
                    }
                }
                .padding(.top, 10)
                .padding(.leading, 10)
                .padding(.trailing, 10)
            }
            .navigationTitle("Settings")
            .toolbarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.primaryBlue, for: .navigationBar)
            .alert(isPresented: $alertViewModel.showAlert) {
                Alert(title: Text(alertViewModel.alert?.title ?? "Unknown"),
                      message: Text(alertViewModel.alert?.message ?? "Unknown"),
                      primaryButton: .default(Text("Ok"), action: {
                    Task {
                        do {
                            try viewModel.logout()
                            appRootManager.currentRoot = .splash
                        } catch {
                            print("error")
                        }
                    }
                    
                }),
                      secondaryButton: alertViewModel.alert?.secundaryButton ?? .cancel())
            }
            .applyNavigation(coordinator: settingsNavViewModel.coordinator)

        }
    }
}

//#Preview {
//    SettingsView()
//}
