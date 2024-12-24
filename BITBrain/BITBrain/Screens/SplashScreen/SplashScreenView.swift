//
//  SplashScreenView.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 22.10.24..
//

import SwiftUI
import Supabase

struct SplashScreenView: View {
    
    @EnvironmentObject private var appRootManager: AppRootManager
    @ObservedObject var viewModel = SplashScreenViewModel()
    @State private var size = 1.0
    @State private var opacity = 0.9
    @State private var isLoggedIn = false
        
    var body: some View {
        ZStack {
            Color(.primaryBlue)
                .edgesIgnoringSafeArea(.all)
            
            
            VStack {
                VStack {
                    Image("spark_icon_image")
                        .resizable()
                        .frame(width: 120.0, height: 120.0)
                    Text("Smart Spark")
                        .font(Font.system(size: 50.0))
                        .foregroundStyle(.white)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.primaryBlue)
            .scaleEffect(size)
            .opacity(opacity)
            .onAppear {
                Task {
                    isLoggedIn = await viewModel.isUserLoggedIn()
                }
                withAnimation(.easeIn(duration: 1.3)) {
                    self.size = 1.3
                    self.opacity = 1.0
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                    appRootManager.currentRoot = isLoggedIn ? .home : .authentication
                }
            }
        }
    }
}

