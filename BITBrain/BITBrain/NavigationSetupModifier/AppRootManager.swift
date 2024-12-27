//
//  AppRootManager.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 25.10.24..
//

import Foundation

protocol AppRootManaging: AnyObject {
    var currentRoot: AppRootManager.AppRoot { get set }
}

final class AppRootManager: ObservableObject, AppRootManaging {
    
    @Published var currentRoot: AppRoot = .splash
    
    enum AppRoot {
        case splash
        case authentication
        case home
    }
}
