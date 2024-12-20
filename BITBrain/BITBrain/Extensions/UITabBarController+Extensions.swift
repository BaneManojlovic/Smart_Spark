//
//  UITabBarController+Extensions.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 8.11.24..
//

import UIKit
import SwiftUI

extension UITabBarController {

    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // Adding rounded corners
        self.tabBar.layer.masksToBounds = true
        self.tabBar.layer.cornerRadius = 20
        self.tabBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
        
        // Adding shadow
//        if let shadowView = view.subviews.first(where: { $0.accessibilityIdentifier == "TabBarShadow" }) {
//            shadowView.frame = tabBar.frame
//        } else {
//            let shadowView = UIView(frame: .zero)
//            shadowView.frame = tabBar.frame
//            shadowView.accessibilityIdentifier = "TabBarShadow"
//            shadowView.backgroundColor = UIColor.white
//            shadowView.layer.cornerRadius = tabBar.layer.cornerRadius
//            shadowView.layer.maskedCorners = tabBar.layer.maskedCorners
//            shadowView.layer.masksToBounds = false
//            shadowView.layer.shadowColor = Color.black.cgColor
//            shadowView.layer.shadowOffset = CGSize(width: 0.0, height: -8.0)
//            shadowView.layer.shadowOpacity = 0.3
//            shadowView.layer.shadowRadius = 10
//            view.addSubview(shadowView)
//            view.bringSubviewToFront(tabBar)
//        }
    }
}

