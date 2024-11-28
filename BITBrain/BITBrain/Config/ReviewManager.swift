//
//  ReviewManager.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 28.11.24..
//

import Foundation
import StoreKit
import SwiftUI

class ReviewManager {

    static func requestReview() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            if let scene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene {
                SKStoreReviewController.requestReview(in: scene)
            }
        }
    }

    static func requestReviewManually() {
        let url = "https://apps.apple.com/us/app/id6737848035?action=write-review"
        guard let writeReviewURL = URL(string: url)
        else { fatalError("Expected a valid URL") }
        UIApplication.shared.open(writeReviewURL, options: [:], completionHandler: nil)
    }
}
