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
    @StateObject var chatController: ChatController = .init()
    @State var messageText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Image("spark_icon_image")
                        .resizable()
                        .background(Color.primaryBlue)
                        .frame(width: 48.0, height: 48.0)
                        .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 5.0, bottomLeading: 5.0, bottomTrailing: 5.0, topTrailing: 5.0)))
                    Spacer()
                    Text("Enjoy chatting!")
                        .font(.system(size: 22, weight: .semibold, design: .serif))
                        .foregroundStyle(Color.darkBlue)
                    Spacer()
                    Button(action: {
                        dismiss()
                    }) {
                        Image(systemName: "xmark")
                            .foregroundColor(.primaryBlue)
                            .font(.title2)
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
                Divider()
                HStack {
                    TextField("Type message here...", text: $messageText, axis: .vertical)
                        .padding(5)
                        .foregroundColor(.black)
                        .background(Color.gray.opacity(0.1))
                        .overlay(RoundedRectangle(cornerRadius: 0)
                            .stroke(Color.lightGrayBit, lineWidth: 1)
                        )
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
        }
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden()
        .toolbar(.hidden, for: .tabBar)
    }

    func sendMessageAction() {
        print("Sending message ...")
        self.chatController.sendMessage(content: messageText)
        messageText = ""
    }
}
