//
//  TutorialView.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 8.11.24..
//

import SwiftUI

struct TutorialView: View {
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack {
            HStack {
                Image("spark_icon_image")
                    .resizable()
                    .background(Color.primaryBlue)
                    .frame(width: 48.0, height: 48.0)
                    .clipShape(.rect(cornerRadii: RectangleCornerRadii(topLeading: 5.0, bottomLeading: 5.0, bottomTrailing: 5.0, topTrailing: 5.0)))
                Spacer()
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.primaryBlue)
                        .font(.title2)
                }
            }
            .padding(.leading, 10)
            .padding(.trailing, 10)
            .padding(.top, 2)
            Divider()
            Spacer()
            Text("This will be tutorial...")
            Spacer()
        }
       
    }
}
