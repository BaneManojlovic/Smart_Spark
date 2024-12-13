//
//  PrivacyPolicyView.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 25.10.24..
//

import SwiftUI

struct PrivacyPolicyView: View {
    
    @ObservedObject var settingsNavViewModel: SettingsNavigationViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    WebView()
                        .edgesIgnoringSafeArea(.all)
                    
                }
            }
        }
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    settingsNavViewModel.coordinator.goBack()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.primaryBlue)
                        .font(.title2)
                }
            }
        }
    }
}
