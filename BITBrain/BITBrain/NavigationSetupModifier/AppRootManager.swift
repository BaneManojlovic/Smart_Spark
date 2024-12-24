//
//  AppRootManager.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 25.10.24..
//

import Foundation

protocol AppRootManaging: AnyObject {
    var currentRoot: AppRootManager.eAppRoots { get set }
}

final class AppRootManager: ObservableObject, AppRootManaging {
    
    @Published var currentRoot: eAppRoots = .splash
    
    enum eAppRoots {
        case splash
        case authentication
        case home
    }
}
