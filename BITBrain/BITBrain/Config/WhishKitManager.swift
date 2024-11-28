//
//  WhishKitManager.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 27.11.24..
//

import Foundation
import WishKit
import SwiftUI
import WishKitShared

final class WhishKitManager {

    func configureWishKit() {
        WishKit.configure(with: "132BC9F7-85F6-4307-8694-6A02FC8A3CD2")
        setupWishKitUI()
    }

    func setupWishKitUI() {
        WishKit.theme.primaryColor = .primaryBlue
    }
}
