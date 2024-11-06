//
//  AppDelegate.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 26.10.24..
//

import Foundation
import SwiftUI
import Firebase
import SwiftUI
import Firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
