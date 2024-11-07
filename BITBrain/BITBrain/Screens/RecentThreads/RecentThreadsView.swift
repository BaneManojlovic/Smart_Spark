//
//  RecentThreadsView.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 22.10.24..
//

import SwiftUI

struct RecentThreadsView: View {
    
    @ObservedObject var chatNavViewModel: ChatNavigationViewModel
    @State var showAlert: Bool = false
    @StateObject var chatController: ChatController = .init()
    @State var messageText: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView {
                    ForEach(chatController.messages) { message in
                        MessageCellView(message: message)
                            .padding(EdgeInsets(top: 2.5, leading: 10.0, bottom: 2.5, trailing: 10.0))
                    }
                }
                Divider()
                HStack {
                    TextField("Message...", text: $messageText, axis: .vertical)
                        .padding(5)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    Button {
                        sendMessageAction()
                    } label: {
                        Image(systemName: "paperplane")
                    }
                }
                .padding()
            }
            .background(.white)
//            ZStack {
//                Color.gray
//                    .edgesIgnoringSafeArea(.all)
//                
//                VStack {
//                    Text("List of recent threads")
//                        .fontWeight(.bold)
//                    
//                    Button("Tap to see alert") {
//                        showAlert = true
//                    }
//                    .alert(isPresented: $showAlert) {
//                        
//                        Alert(title: Text("This is title"),
//                              message: Text("This is message"),
//                              primaryButton: .destructive(Text("Ok")) {
//                            print("Ok tapped")
//                        },
//                              secondaryButton: .cancel())
//                        
//                    }
//                }
//                
//            }
        }
        .navigationBarHidden(false)
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    chatNavViewModel.coordinator.goBack()
                    print("back back ...")
                }) {
                    Image(systemName: "arrow.backward")
                        .foregroundColor(.primaryBlue)
                        .font(.title2)
                }
            }
        }
        
        
    }
    
    
    func sendMessageAction() {
        print("Sending message ...")
        self.chatController.sendMessage(content: messageText)
        messageText = ""
    }
}
////
//#Preview {
//    RecentThreadsView()
//}
