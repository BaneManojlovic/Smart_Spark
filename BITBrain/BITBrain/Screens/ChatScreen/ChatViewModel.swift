//
//  ChatViewModel.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 31.10.24..
//

import Foundation
import OpenAI

class ChatViewModel: ObservableObject {
    
    @Published var messages: [AppMessage] = []
    @Published var messageText: String = ""
    let chatId: String
    
    init(chatId: String) {
        self.chatId = chatId
    }
    
    func fetchData() {
        messages.append(AppMessage(id: "1", text: "Hello", role: "user", createdAt: Date()))
    }
}

struct AppMessage: Identifiable, Codable, Hashable {
    let id: String
    let text: String
    let role: String
    let createdAt: Date
}
