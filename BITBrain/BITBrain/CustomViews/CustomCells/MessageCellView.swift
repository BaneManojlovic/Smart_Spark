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
            HStack(alignment: .bottom) {
                Spacer()
                Text(message.content)
                    .padding()
                    .foregroundColor(.black)
                    .background(Color.primaryBlue.opacity(0.7))
                    .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 20, bottomLeading: 20, bottomTrailing: 0, topTrailing: 20)))
                Image(systemName: "person.fill")
                    .resizable()
                    .background(Color.primaryBlue)
                    .frame(width: 36.0, height: 36.0)
                    .foregroundColor(.white)
                    .clipShape(.circle)
                    .overlay(Circle()
                        .stroke(Color.primaryBlue, lineWidth: 1))
                    
            }
        } else {
            HStack(alignment: .bottom) {
                Image("spark_icon_image")
                    .resizable()
                    .background(Color.primaryBlue)
                    .frame(width: 36.0, height: 36.0)
                    .clipShape(.circle)
                    .overlay(Circle()
                        .stroke(Color.primaryBlue, lineWidth: 1))
                Text(message.content)
                    .padding()
                    .foregroundColor(.black)
                    .background(Color.darkGrayBit.opacity(0.6))
                    .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 20, bottomLeading: 0, bottomTrailing: 20, topTrailing: 20)))
                Spacer()
            }
        }
    }
}

