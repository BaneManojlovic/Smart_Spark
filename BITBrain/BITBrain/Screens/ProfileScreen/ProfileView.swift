//
//  ProfileView.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 25.10.24..
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var settingsNavViewModel: SettingsNavigationViewModel
    @ObservedObject var viewModel = ProfileViewModel()

    var body: some View {
        
        NavigationView {
            ZStack {
                Color.white
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Profile screen \n\n profile: \n \(viewModel.showUserData())")
                        .frame(alignment: .center)
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
                    Image(systemName: "chevron.left")
                        .foregroundColor(.primaryBlue)
                        .font(.title2)
                    Text("Settings")
                        .foregroundStyle(.primaryBlue)
                }
            }
        }
    }
}



//
//#Preview {
//    ProfileView()
//}
