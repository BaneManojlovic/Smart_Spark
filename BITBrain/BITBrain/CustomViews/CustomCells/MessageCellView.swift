//
//  MessageCellView.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 31.10.24..
//

import SwiftUI

struct MessageCellView: View {
    
    var message: Message
    
    var body: some View {
        if message.isUser {
            HStack {
                Spacer()
                Text(message.content)
                    .padding()
                    .background(Color.cyan.opacity(0.5))
                    .clipShape(Capsule())
            }
        } else {
            HStack {
                Text(message.content)
                    .padding()
                    .background(Color.gray.opacity(0.5))
                    .clipShape(Capsule())
                Spacer()
            }
        }
    }
}
//
//#Preview {
//    MessageCellView(message: Message.init(content: "Hello world", isUser: true))
//}
