//
//  SecuredEyeButtonView.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 22.11.24..
//

import SwiftUI

struct SecuredEyeButtonView: View {

    @Binding var isSecured: Bool

    var body: some View {
        Button(action: {
            isSecured.toggle()
        }, label: {
            Image(systemName: self.isSecured ? "eye.slash" : "eye")
                .accentColor(.gray)
                .offset(x: -4, y: 0)
        })
        .frame(width: 35, height: 55, alignment: .center)
    }
}
