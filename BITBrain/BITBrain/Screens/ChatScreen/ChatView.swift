//
//  ChatView.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 22.10.24..
//

import SwiftUI

struct ChatView: View {

    @StateObject var chatController: ChatController
    @ObservedObject var userDefaultsHelper = UserDefaultsHelper()
    @State private var isPresented = false
    @State private var isAlertPresented = false
    @State private var isTutorialPresented = false
    @State private var message: String = "No messages for now."
    @State private var scale = 1.0
    @StateObject var alertViewModel = AlertViewModel()
    @State private var apiKeyValue = ""
    @State private var chatActivationButtonTitleText = ""
    
    
    var body: some View {
        
        NavigationStack {
            ZStack(alignment: .center) {
                Color.white
                    .edgesIgnoringSafeArea(.all)
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
//                                isTutorialPresented = true
                                Task {
                                    await self.saveUser()
                                }
                                
                            }) {
                                Image(systemName: "info.circle")
                                    .foregroundColor(.darkBlue)
                                    .font(.title2)
                            }
                        }
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                        .padding(.top, -10)
                        .padding(.bottom, 14)
                    
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.lightGrayBit)
                        .edgesIgnoringSafeArea(.bottom)
                        .offset(y: 0)
                    
                    HStack(alignment: .center) {
                        if let existingApiKey = userDefaultsHelper.getOpenAiAPIToken(), !existingApiKey.isEmpty {
                            Text("•" + " " + "Active")
                                .foregroundStyle(Color.green)
                                .bold()
                                .italic()
                        } else {
                            Text("•" + " " + "Inactive")
                                .foregroundStyle(Color.gray)
                                .bold()
                                .italic()
                        }
                    }
                    .frame(height: 12.0)

                    Button(action: {

                        if let existingApiKey = userDefaultsHelper.getOpenAiAPIToken(), !existingApiKey.isEmpty {
                            self.apiKeyValue = existingApiKey
                            chatController.setApiToken(self.apiKeyValue)
                            isPresented = true
                        } else {
                            if self.apiKeyValue.isEmpty {
                                print("bane = \(apiKeyValue)")
                                isAlertPresented = true
                            } else {
                                chatController.setApiToken(self.apiKeyValue)
                                isPresented = true
                            }
                        }
                        
                    }, label: {
                        
                        if let existingApiKey = userDefaultsHelper.getOpenAiAPIToken(), !existingApiKey.isEmpty {
                            Text("Tap here to use your Smart Spark chat.")
                                .font(.system(size: 18, weight: .semibold, design: .serif))
                                .italic()
                                .frame(width: UIScreen.main.bounds.width*0.94, height: 60.0, alignment: .center)
                                .foregroundColor(.white)
                                .background(Color.primaryBlue.opacity(0.7))
                                .overlay(RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.primaryBlue, lineWidth: 1)
                                )
                        } else {
                            Text("Tap here to activate and start \n using your Smart Spark chat.")
                                .font(.system(size: 18, weight: .semibold, design: .serif))
                                .italic()
                                .frame(width: UIScreen.main.bounds.width*0.94, height: 60.0, alignment: .center)
                                .foregroundColor(.white)
                                .background(Color.primaryBlue.opacity(0.7))
                                .overlay(RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color.primaryBlue, lineWidth: 1)
                                )
                        }
                    })
                    .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 20, bottomLeading: 20, bottomTrailing: 20, topTrailing: 20)))
                    .shadow(color: .gray, radius: 2, x: 0, y: 6)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .ignoresSafeArea(.keyboard)
            .navigationBarHidden(false)
            .navigationBarBackButtonHidden()
            .toolbar(.visible, for: .tabBar)
            .fullScreenCover(isPresented: $isPresented) {
                ActiveChatView(chatController: ChatController(apiToken: apiKeyValue))
            }
            .fullScreenCover(isPresented: $isTutorialPresented, content: TutorialView.init)
            .alert("To start chatting,\n please enter your valid API Key.", isPresented: $isAlertPresented) {
                TextField("", text: $apiKeyValue)
                HStack {
                    Button("Cancel") { }
                    Button("Ok") {
                        if apiKeyValue != "" {
                            print("API Key = \(apiKeyValue)")
                            chatController.setApiToken(apiKeyValue)
                            self.apiKeyValue = apiKeyValue
                            self.userDefaultsHelper.setOpenAiAPIToken(apiKeyValue)
                            isPresented.toggle()
                        } else {
                            print("API Key is empty!")
                        }
                    }
                    
                }
               
            }
            
        }
        .onAppear {
            if let existingApiKey = userDefaultsHelper.getOpenAiAPIToken(), 
                (!existingApiKey.isEmpty || existingApiKey != "") {
                apiKeyValue = existingApiKey
            } else {
                apiKeyValue = ""
            }
        }
    }
    
    
    
    func saveUser() async {
//        if let user = userDefaultsHelper.getUser() {
//            var userModel = UserModel(user: user)
//            userModel.username = "Baki Maki"
//            do {
//                try await UserDataManager.shared.createNewUser(model: userModel)
//                print("ok")
//            } catch {
//                print("not ok")
//            }
//        }
//
        print("Save user...")
    }
}

