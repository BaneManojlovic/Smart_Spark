//
//  ChatView.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 22.10.24..
//

import SwiftUI

struct HomeView: View {

    @StateObject var chatController: ChatController
    @StateObject var userDefaultsHelper = UserDefaultsHelper()
    @State private var isPresented = false
    @State private var isTutorialPresented = false
    @State private var isCustomSheetPresented = false
    @State private var apiKeyValue = ""

    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                Color.white.edgesIgnoringSafeArea(.all)
                Image("chat_background_image")
                    .resizable()
                    .scaledToFit()
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    HStack {
                        Spacer()
                        Text("Welcome to Smart Spark!")
                            .font(.system(size: 23, weight: .semibold, design: .serif))
                            .foregroundStyle(Color.darkBlue)
                        Spacer()
                        Button(action: {
                            isTutorialPresented = true
                        }) {
                            Image(systemName: "info.circle")
                                .foregroundColor(.darkBlue)
                                .font(.title2)
                        }
                    }
                    .padding(.horizontal, 10)
                    .padding(.vertical, 14)
                    
                    Divider()
                        .background(Color.lightGrayBit)
                        .padding(.bottom, 10)

                    HStack {
                        if let existingApiKey = userDefaultsHelper.apiToken, !existingApiKey.isEmpty {
                            Text("• Active")
                                .foregroundStyle(Color.green)
                                .bold()
                                .italic()
                        } else {
                            Text("• Inactive")
                                .foregroundStyle(Color.gray)
                                .bold()
                                .italic()
                        }
                    }
                    .frame(height: 12)

                    Button(action: {
                        if let existingApiKey = userDefaultsHelper.getOpenAiAPIToken(), !existingApiKey.isEmpty {
                            apiKeyValue = existingApiKey
                            chatController.setApiToken(apiKeyValue)
                            isPresented = true
                        } else {
                            isCustomSheetPresented = true
                        }
                    }) {
                        Text(userDefaultsHelper.getOpenAiAPIToken() != nil ?
                             "Tap here to use your Smart Spark chat." :
                             "Tap here to activate and start\nusing your Smart Spark chat.")
                            .font(.system(size: 18, weight: .semibold, design: .serif))
                            .italic()
                            .frame(width: UIScreen.main.bounds.width * 0.94, height: 60)
                            .foregroundColor(.white)
                            .background(Color.primaryBlue.opacity(0.7))
                            .cornerRadius(20)
                            .shadow(color: .gray, radius: 2, x: 0, y: 6)
                    }
                    Spacer()
                }
            }
            .ignoresSafeArea(.keyboard)
            .fullScreenCover(isPresented: $isPresented) {
                ActiveChatView(chatController: chatController)
            }
            .fullScreenCover(isPresented: $isTutorialPresented, content: TutorialView.init)
            .sheet(isPresented: $isCustomSheetPresented) {
                CustomSheetView(
                    isVisible: $isCustomSheetPresented,
                    apiKeyValue: $apiKeyValue
                ) {
                    if !apiKeyValue.isEmpty {
                        userDefaultsHelper.apiToken = apiKeyValue
                        chatController.setApiToken(apiKeyValue)
                        userDefaultsHelper.setOpenAiAPIToken(apiKeyValue)
                        isCustomSheetPresented = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            isPresented = true
                        }
                    }
                }
                .presentationDetents([.height(250)])
            }
        }
        .onAppear {
            apiKeyValue = userDefaultsHelper.getOpenAiAPIToken() ?? ""
        }
    }
}
