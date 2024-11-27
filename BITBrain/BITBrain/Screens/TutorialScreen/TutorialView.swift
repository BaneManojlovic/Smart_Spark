//
//  TutorialView.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 8.11.24..
//

import SwiftUI

struct TutorialView: View {
    
    @Environment(\.dismiss) var dismiss
    let tutorialData: [TutorialData] = [TutorialData(image: "face.smiling", title: "Welcome to Smart Spark App"),
                                        TutorialData(image: "bubble.left.and.text.bubble.right", title: "Chat easy with your artificial inteligence advisor."),
                                        TutorialData(image: "lightbulb.max", title: "Suggest some smart features to add in this app."),
                                        TutorialData(image: "ear.badge.checkmark", title: "Recommend Smart Spark App to your friends!")]

    var body: some View {
        
        ZStack {
            Color.white
                .edgesIgnoringSafeArea(.all)
            VStack {

                HStack {
                    Image("spark_icon_image")
                        .resizable()
                        .background(Color.primaryBlue)
                        .frame(width: 48.0, height: 48.0)
                        .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 5.0, bottomLeading: 5.0, bottomTrailing: 5.0, topTrailing: 5.0)))
                    Spacer()
                    Text("Smart Spark!")
                        .font(.system(size: 23, weight: .semibold, design: .serif))
                        .foregroundStyle(Color.darkBlue)
                    Spacer()
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Skip")
                            .foregroundColor(.primaryBlue)
                            .font(.title3)
                    }
                }
                .padding(.leading, 10)
                .padding(.trailing, 10)
                .padding(.top, 2)
               
                Spacer()
               
                TabView {
                    ForEach(tutorialData) { item in
                        TutorialCardView(card: item)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
            }
            
        }
        
    }
}
