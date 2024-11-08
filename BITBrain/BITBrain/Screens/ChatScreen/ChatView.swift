//
//  ChatView.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 22.10.24..
//

import SwiftUI

struct ChatView: View {
    
    @ObservedObject var chatNavViewModel: ChatNavigationViewModel

    @State private var isPresented = false
    @State private var isLoading = false
    @State private var message: String = "No messages for now."
    @State private var scale = 1.0
    
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
                                //                            dismiss()
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
                        Text("Welcome animation!")
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
                        print("test ... alert popup for entering Api Key")
                        isPresented.toggle()
                    }, label: {
                        Text("To start chatting,\n please enter your valid API Key.")
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
            .fullScreenCover(isPresented: $isPresented, content: ActiveChatView.init)
        }
    }
}

