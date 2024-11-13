//
//  ChatView.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 22.10.24..
//

import SwiftUI

struct ChatView: View {

    @StateObject var chatController: ChatController

    @State private var isPresented = false
    @State private var isAlertPresented = false
    @State private var isTutorialPresented = false
    @State private var message: String = "No messages for now."
    @State private var scale = 1.0
    @StateObject var alertViewModel = AlertViewModel()
    @State private var apiKeyValue = ""
    
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color.white
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    ZStack {
                        Color.primaryBlue
                            .edgesIgnoringSafeArea(.all)
                        HStack {
                            Spacer()
                            Text("Welcome to Smart Spark!")
                                .font(.system(size: 22, weight: .semibold, design: .serif))
                                .foregroundStyle(Color.white)
                            Spacer()
                            Button(action: {
                                isTutorialPresented = true
                            }) {
                                Image(systemName: "info.circle")
                                    .foregroundColor(.white)
                                    .font(.title2)
                            }
                        }
                        .padding(.leading, 10)
                        .padding(.trailing, 10)
                        .padding(.top, 0)
                        .padding(.bottom, 14)
                    }
                    
                   Spacer()
                    Button(action: {
                        scale += 1
                    }, label: {
                        Text("Welcome animation! \n Will be done soon.")
                            .italic()
                            .scaleEffect(scale)
                            .animation(.easeIn, value: scale)
                            .frame(width: UIScreen.main.bounds.width*0.90, height: UIScreen.main.bounds.height/3, alignment: .center)
                            .foregroundColor(.darkBlue)
                            .background(Color.primaryBlue.opacity(0.7))
                            .overlay(RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.primaryBlue, lineWidth: 1)
                            )
                    })
                    .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 20, bottomLeading: 20, bottomTrailing: 20, topTrailing: 20)))
                    .shadow(color: .gray, radius: 2, x: 0, y: 6)
                    Spacer(minLength: 20)
                    Button(action: {
                        if apiKeyValue.isEmpty {
                            isAlertPresented = true
                        } else {
                            chatController.setApiToken(apiKeyValue)
                            isPresented = true
                        }
                        
                    }, label: {
                        Text("Tap here \n to learn how you can \n start using your \n Smart Spark chat.")
                            .font(.system(size: 24, weight: .semibold, design: .serif))
                            .italic()
                            .frame(width: UIScreen.main.bounds.width*0.90, height: UIScreen.main.bounds.height/3, alignment: .center)
                            .foregroundColor(.darkBlue)
                            .background(Color.primaryBlue.opacity(0.7))
                            .overlay(RoundedRectangle(cornerRadius: 20)
                                .stroke(Color.primaryBlue, lineWidth: 1)
                            )
                    })
                    .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 20, bottomLeading: 20, bottomTrailing: 20, topTrailing: 20)))
                    .shadow(color: .gray, radius: 2, x: 0, y: 6)
                    Spacer(minLength: 60)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
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
                            self.apiKeyValue = apiKeyValue
                            chatController.setApiToken(apiKeyValue)
                            isPresented.toggle()
                        } else {
                            print("API Key is empty!")
                        }
                    }
                    
                }
               
            }
            
        }
    }
}

