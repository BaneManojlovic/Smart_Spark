//
//  ProfileView.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 25.10.24..
//

import SwiftUI

struct ProfileView: View {
    
    @ObservedObject var settingsNavViewModel: SettingsNavigationViewModel

    var body: some View {
        
        NavigationView {
            ZStack {
                Color.gray
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Profile screen")
                        .fontWeight(.bold)
                    
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
                        .foregroundColor(.black)
                        .font(.title2)
                }
            }
        }
    }
}



//
//#Preview {
//    ProfileView()
//}
