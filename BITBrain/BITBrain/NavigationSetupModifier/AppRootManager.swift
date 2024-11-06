//
//  AppRootManager.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 25.10.24..
//

import Foundation

final class AppRootManager: ObservableObject {
    
    @Published var currentRoot: eAppRoots = .splash
    
    enum eAppRoots {
        case splash
        case authentication
        case home
    }
}
