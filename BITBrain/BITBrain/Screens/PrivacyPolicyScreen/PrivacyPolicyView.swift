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
                    Text("Privacy Policy screen")
                        .fontWeight(.bold)
                        .foregroundStyle(Color.darkBlue)
                    
                }
            }
        }
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    settingsNavViewModel.coordinator.goBack()
                    print("back back ...")
                }) {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.primaryBlue)
                        .font(.title2)
                }
            }
        }
    }
}

//#Preview {
//    PrivacyPolicyView()
//}
