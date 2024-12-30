//
//  ProfileFieldView.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 27.12.24..
//

import SwiftUI

struct ProfileFieldView: View {
    let title: String
    let value: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text(title)
                .font(.caption)
                .foregroundColor(.gray)
            Text(value)
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.black)
            Divider()
        }
    }
}
