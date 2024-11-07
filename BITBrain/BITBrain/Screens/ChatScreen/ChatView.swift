//
//  ChatView.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 22.10.24..
//

import SwiftUI

struct ChatView: View {
    
    @ObservedObject var chatNavViewModel: ChatNavigationViewModel

    @State private var isLoading = false
    @State private var message: String = "No messages for now."
    
    var body: some View {
        
        NavigationStack {
            
            ZStack {
                Color.white
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                   Spacer()
                    Button(action: {
                        print("test ... open tutorial")
                    }, label: {
                        Text("Introduction ... open tuttorial slideshow view...")
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
                        print("test ... alert popup for entering Api Key")
                    }, label: {
                        Text("Please enter your valid API Key for chat")
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
            .navigationTitle("Welcome to Smart Spark")
            .toolbarTitleDisplayMode(.inline)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarBackground(.primaryBlue, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        // Action when the "New Chat" button is tapped list.bullet.rectangle
                        print("Recent chat's")
                        chatNavViewModel.coordinator.navigateToRecentThreads()
                    }) {
                        Image(systemName: "list.bullet.rectangle")
                            .foregroundColor(.black)
                            .tint(.darkBlue)
                            .font(.title2)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // Action when the "New Chat" button is tapped list.bullet.rectangle
                        print("New Chat tapped!")
                        reloadChat()
                    }) {
                        Image(systemName: "square.and.pencil")
                            .foregroundColor(.black)
                            .font(.title2)
                    }
                }
            }
            .background(Color.black)
            .applyNavigation(coordinator: chatNavViewModel.coordinator)
        }
    }
    
    private func reloadChat() {
        isLoading = true // Start loading
        message = "Loading new chat..." // Optional: update the message
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // Simulate loading delay
            isLoading = false // Stop loading
            message = "New message received!" // Update the message or chat content
        }
    }
}

//#Preview {
//    ChatView()
//}
