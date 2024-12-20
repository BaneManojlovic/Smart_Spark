//
//  TutorialCardView.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 27.11.24..
//

import Foundation
import SwiftUI


struct TutorialCardView: View {
    
    var card: TutorialData
    
    var body: some View {
        
        ZStack {
            VStack(alignment: .center, spacing: 10) {
                Spacer()
                Image(systemName: card.image)
                    .resizable()
                    .scaledToFit()
                    .foregroundStyle(.primaryBlue)
                    .frame(width: 150, height: 150, alignment: .center)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 8, x: 6, y: 8)
                    .padding(10)
                Text(card.title)
                    .foregroundStyle(Color.darkBlue)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.15), radius: 2, x: 2, y: 2)
                    .padding(10)
                Spacer()
            }
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .center)
            .background(.white)
            
        }
    }
    
}

struct SkipButtonView: View {
    
    @AppStorage("isOnboarding") var isOnboarding: Bool?

    var body: some View {
      Button(action: {
        isOnboarding = false
      }) {
        HStack(spacing: 8) {
          Text("Skip")
          Image(systemName: "arrow.right.circle")
            .imageScale(.large)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 10)
        .background(
          Capsule().strokeBorder(Color.darkBlue, lineWidth: 1.25)
        )
      }
      .accentColor(Color.white)
    }
}
