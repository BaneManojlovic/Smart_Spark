//
//  SettingsViewCell.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 22.10.24..
//

import SwiftUI

struct SettingsViewCell: View {
    
    let item: SettingsItem
    @ObservedObject var alertViewModel: AlertViewModel
    @EnvironmentObject private var appRootManager: AppRootManager
    
    @ObservedObject var viewModel: SettingsNavigationViewModel
    
    var body: some View {
        VStack {
            Image(systemName: item.iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 60, height: 60)
                .foregroundColor(.primaryBlue)
            
            
            Text(item.title)
                .font(.headline)
                .foregroundColor(.primaryBlue)
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.white.opacity(0.7))
        .cornerRadius(10)
        .overlay( /// apply a rounded border
            RoundedRectangle(cornerRadius: 10)
                .stroke(.primaryBlue, lineWidth: 2)
        )
        .onTapGesture {
            print("Cell \(item.title) tapped")
            
            switch item.title {
            case "Profile":
                viewModel.coordinator.navigateToProfile()
            case "Privacy Policy":
                viewModel.coordinator.navigateToPrivacyPolicy()
            case "Thread Archive":
                viewModel.coordinator.navigateToThreadArchive()
            case "Logout":
                alertViewModel.presentAlert(alert:
                                                CustomAlert(title: "\(item.title)",
                                                            message: "Are you sure, that you want to logout?",
                                                            primaryButton: .default(Text("Ok")) {
                    appRootManager.currentRoot = .splash
                },
                                                            secundaryButton: .cancel()))
            default:
                
                alertViewModel.presentAlert(alert:
                                                CustomAlert(title: "\(item.title)",
                                                            message: "",
                                                            primaryButton: .default(Text("Ok")) {
                    print("Cell \(item.title) tapped")
                },
                                                            secundaryButton: .cancel()))
            }
            
        }
    }
}
