//
//  RecentThreadsView.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 22.10.24..
//

import SwiftUI

struct ActiveChatView: View {
    
    @Environment(\.dismiss) var dismiss

    @State var showAlert: Bool = false
    @StateObject var chatController: ChatController
    @EnvironmentObject var appState: AppState
    @State var messageText: String = ""
    @State private var refreshTrigger = UUID()
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Button(action: {
                        deactivateChat()
                    },label: {
                        Text("Deactivate")
                            .foregroundStyle(.red)
                            .font(.body)
                    })
                    Spacer()
                    Text("Enjoy chatting!")
                        .font(.system(size: 20, weight: .bold, design: .serif))
                        .foregroundStyle(Color.darkBlue)
                    Spacer()
                    Button(action: {
                        dismiss()
                    }) {
                        Text("     Close")
                            .foregroundStyle(.primaryBlue)
                            .font(.body)
                    }
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.top, 2)
                Divider()
                ScrollView {
                    ForEach(chatController.messages) { message in
                        MessageCellView(message: message)
                            .padding(EdgeInsets(top: 2.5, leading: 10.0, bottom: 2.5, trailing: 10.0))
                    }
                }
                .id(refreshTrigger)
                
                Divider()
                HStack {
                    ZStack(alignment: .leading) {
                        if messageText.isEmpty {
                            Text("Type message here...")
                                .foregroundColor(.gray)
                                .padding(.leading, 6)
                        }
                        TextField("", text: $messageText, axis: .vertical)
                            .tint(Color.primaryBlue)
                            .foregroundColor(Color.darkBlue)
                            .padding(5)
                            .background(Color.gray.opacity(0.1))
                            .overlay(RoundedRectangle(cornerRadius: 0)
                                .stroke(Color.lightGrayBit, lineWidth: 1)
                            )
                    }
                    Button {
                        sendMessageAction()
                    } label: {
                        Image(systemName: "paperplane")
                            .foregroundStyle(.primaryBlue)
                    }
                }
                .padding()
            }
            .background(.white)
            .onChange(of: chatController.messages.count) { _, _ in
                refreshTrigger = UUID()
            }
        }
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden()
        .toolbar(.hidden, for: .tabBar)
    }

    func sendMessageAction() {
        appState.chatController.sendMessage(content: messageText)
        messageText = ""
    }

    func deactivateChat() {
        appState.clearApiKey() // Clear the API key from AppState
        dismiss() // Dismiss the ActiveChatView
    }
}
