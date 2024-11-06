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
                Color.gray
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    
                    if isLoading {
                        ProgressView("Loading...") // Show a spinner when loading
                            .progressViewStyle(CircularProgressViewStyle(tint: .blue))
                            .font(.headline)
                    } else {
                        Text(message) // Simulated chat message or content
                            .font(.system(size: 20.0))
                            .foregroundStyle(.white)
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                
                
                
            }
            .navigationTitle("Chat")
            .toolbarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        // Action when the "New Chat" button is tapped list.bullet.rectangle
                        print("Recent chat's")
                        chatNavViewModel.coordinator.navigateToRecentThreads()
                    }) {
                        Image(systemName: "list.bullet.rectangle")
                            .foregroundColor(.black)
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
