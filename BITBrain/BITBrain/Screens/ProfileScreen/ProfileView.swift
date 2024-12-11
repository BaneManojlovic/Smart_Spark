//
//  ProfileView.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 25.10.24..
//

import SwiftUI

struct ProfileView: View {
    
    @EnvironmentObject private var appRootManager: AppRootManager
    @ObservedObject var alertViewModel = AlertViewModel()
    @ObservedObject var settingsNavViewModel: SettingsNavigationViewModel
    @ObservedObject var viewModel = ProfileViewModel()
    @State private var isLoading = false

    var body: some View {
        
        NavigationView {
            ZStack {
                Color.white
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .center, spacing: 10) {
                    Image("test_person_image")
                        .resizable()
                        .foregroundColor(.primaryBlue)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2.0, alignment: .center)
                        .scaledToFill()
                    HStack {
                        Text("UserID:")
                            .frame(alignment: .center)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.darkBlue)
                        Text(" \(viewModel.getUserId())")
                            .frame(alignment: .center)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.darkBlue)
                    }
                    HStack {
                        Text("email:")
                            .frame(alignment: .center)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.darkBlue)
                        Text(" \(viewModel.showUserData())")
                            .frame(alignment: .center)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.darkBlue)
                    }
                    Spacer()
                    Button(action: deleteAccount) {
                        HStack {
                            Spacer()
                            Text("Delete account")
                            Spacer()
                          }
                          .contentShape(Rectangle())
                    }
                    .foregroundStyle(Color.red)
                    .frame(width: 300, height: 50)
                    .background(Color.darkBlue)
                    .cornerRadius(10)
                    .padding()
                }
                
                if isLoading {
                    ProgressView()
                        .controlSize(.large)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.3))
                        .foregroundColor(.white)
                        .edgesIgnoringSafeArea(.all)
                }
            }
        }
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden()
        .alert(isPresented: $alertViewModel.showAlert) {
            Alert(title: Text(alertViewModel.alert?.title ?? "Unknown"), message: Text(""), primaryButton: .default(Text("Ok")), secondaryButton: .cancel())
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    settingsNavViewModel.coordinator.goBack()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.primaryBlue)
                        .font(.title2)
                    Text("Settings")
                        .foregroundStyle(.primaryBlue)
                }
            }
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    ReviewManager.requestReview()
                }) {
                    Image(systemName: "star")
                        .foregroundColor(.primaryBlue)
                        .font(.title2)
                }
            }
        }
    }
    // TODO: - Fix this
//    func doYouWantToDeleteAccount() {
//        DispatchQueue.main.async {
//            alertViewModel.presentAlert(alert:
//                                            CustomAlert(title: "Are you sure, that you want to delete account?",
//                                                        message: "",
//                                                        primaryButton: .default(Text("Ok")) {
//                deleteAccount()
//            },
//                                                        secundaryButton: .cancel()))
//        }
//    }
    
    func deleteAccount() {
        print("delete account tapped....")
        isLoading = true
        viewModel.deleteAction { success in
            DispatchQueue.main.async {
                isLoading = false
                if success {
                    DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                        appRootManager.currentRoot = .splash
                    }
                } else {
                    print("delete account failure ...")
                    // show Alert
                    alertViewModel.presentAlert(alert: CustomAlert(title: "Error while deleting account.",
                                                                   message: "",
                                                                   primaryButton: .default(Text("Ok")), 
                                                                   secundaryButton: .cancel()))
                }
            }
            
        }
    }
}
