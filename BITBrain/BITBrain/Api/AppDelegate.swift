//
//  AppDelegate.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 26.10.24..
//

import Foundation
import SwiftUI
import WishKit

class AppDelegate: NSObject, UIApplicationDelegate {
    
    let wishKitManager = WhishKitManager()
    
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        wishKitManager.configureWishKit()
        return true
    }
}
