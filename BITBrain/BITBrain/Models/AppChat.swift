//
//  AppChat.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 31.10.24..
//

import Foundation
import OpenAI

struct AppChat {
    let id: String
    let topic: String
    let model: String
    let lastMessageSent: Date
    let owner: String
}


struct Message: Identifiable {
    var id: UUID = .init()
    var content: String
    var isUser: Bool
}

class ChatController: ObservableObject {
    @Published var messages: [Message] = []
    // TODO: - Uradi logiku da korisnik za ovo prvo mora da unese vrednost, da bi mogao da koristi chat
    let openAI = OpenAI(apiToken: "")
   

    
    func sendMessage(content: String) {
        let userMessage = Message(content: content, isUser: true)
        self.messages.append(userMessage)
        
        getBotReply(content: content)
    }
    
    func getBotReply(content: String) {
        let messageParam = ChatQuery.ChatCompletionMessageParam.user(.init(content: .string(content)))
        // ovo fejluje iz nekog razloga??
        openAI.chats(query: .init(messages: [messageParam], model: .gpt3_5Turbo)) { result in
            
            switch result {
            case .success(let success):
                guard let choice = success.choices.first else { return }
                let message = choice.message.content?.string
                DispatchQueue.main.async {
                    self.messages.append(Message(content: message ?? "", isUser: false))
                }
            case .failure(let failure):
                print("failure")
            }
        }
            
        
        
        }
    }

