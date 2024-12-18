//
//  ThreadArchiveView.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 25.10.24..
//

import SwiftUI
import WishKit

struct ThreadArchiveView: View {
    
    @ObservedObject var settingsNavViewModel: SettingsNavigationViewModel
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.white
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    WishKit.FeedbackListView().withNavigation()
                        .padding(.bottom, 1)
                        .background(.white)
                    
                    
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
                }
            }
        }
    }
}

//#Preview {
//    ThreadArchiveView()
//}
