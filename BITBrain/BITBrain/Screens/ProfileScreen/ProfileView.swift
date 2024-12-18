//
//  ProfileView.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 25.10.24..
//

import SwiftUI

struct ProfileView: View {

    // MARK: - Objects

    @EnvironmentObject private var appRootManager: AppRootManager
    @ObservedObject var alertViewModel = AlertViewModel()
    @ObservedObject var settingsNavViewModel: SettingsNavigationViewModel
    @ObservedObject var viewModel = ProfileViewModel()

    // MARK: - Properties

    @State private var isLoading = false
    @State private var showDeleteDialog = false

    // MARK: - Layout

    var body: some View {
        
        NavigationView {
            ZStack {
                // Background
                Color.white.edgesIgnoringSafeArea(.all)
                
                VStack {
                    // Profile Image with Camera Icon
                    ZStack {
                        Circle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 120, height: 120)
                        Image(systemName: "person.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 110, height: 110)
                            .clipShape(Circle())
                            .foregroundColor(.darkBlue)
                        
                        // Camera Icon
                        Image(systemName: "camera.fill")
                            .foregroundColor(.white)
                            .background(
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: 30, height: 30)
                            )
                            .offset(x: 40, y: 40)
                    }
                    .padding(.top, 30)
                    
                    // Profile Fields
                    VStack(alignment: .leading, spacing: 20) {
                        ProfileField(title: "Username", value: viewModel.getUsername() ?? "Not set")
                        ProfileField(title: "Email", value: viewModel.showUserData())
                        ProfileField(title: "Phone", value: "(123)-456-7890") // Example placeholder
                        ProfileField(title: "Gender", value: "Male") // Example placeholder
                        ProfileField(title: "Date of Birth", value: "01/01/1990") // Example placeholder
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    
                    Spacer()
                    
                    // Delete Account Button
                    Button(action: callForDeleteAction) {
                        Text("Delete Account")
                            .frame(maxWidth: .infinity)
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.red)
                    }
                    .frame(height: 50)
                    .background(Color.darkBlue)
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 30)
                }
                
                // Loading Indicator
                if isLoading {
                    ProgressView()
                        .controlSize(.large)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.black.opacity(0.3))
                        .foregroundColor(.white)
                        .edgesIgnoringSafeArea(.all)
                }
            }
            .confirmationDialog(
                "Are you sure you want to delete your account?",
                isPresented: $showDeleteDialog,
                titleVisibility: .visible
            ) {
                Button("Delete Account", role: .destructive) {
                    deleteAccount()
                }
                Button("Cancel", role: .cancel) {}
            }
            .alert(isPresented: $alertViewModel.showAlert) {
                Alert(title: Text(alertViewModel.alert?.title ?? "Unknown"),
                      message: Text(""),
                      primaryButton: .default(Text("Ok")),
                      secondaryButton: .cancel())
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
            ToolbarItem(placement: .navigationBarTrailing) {
                HStack(spacing: 20) {
                    Button(action: {
                        saveUpdatedProfile()
                    }) {
                        Text("SAVE")
                            .foregroundColor(.primaryBlue)
                            .bold()
                    }
                    Button(action: {
                        callForRequestReview()
                    }) {
                        Image(systemName: "star")
                            .foregroundColor(.primaryBlue)
                            .font(.title2)
                    }
                }
            }
        }
    }
            
    // MARK: - Methods

    func saveUpdatedProfile() {
        print("Save action tapped")
    }

    func callForRequestReview() {
        ReviewManager.requestReview()
    }

    func callForDeleteAction() {
        showDeleteDialog = true
    }

    func deleteAccount() {
        isLoading = true
        viewModel.deleteAction { success in
            DispatchQueue.main.async {
                isLoading = false
                if success {
                    DispatchQueue.main.asyncAfter(deadline: .now()+1) {
                        appRootManager.currentRoot = .splash
                    }
                } else {
                    alertViewModel.presentAlert(alert: CustomAlert(title: "Error while deleting account.",
                                                                   message: "",
                                                                   primaryButton: .default(Text("Ok")), 
                                                                   secundaryButton: .cancel()))
                }
            }
            
        }
    }
}



// MARK: - Profile Field View
struct ProfileField: View {
    
    // MARK: - Properties
    
    let title: String
    let value: String
    
    // MARK: - Layout
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            Text(value)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.black)
            Divider()
        }
    }
}
