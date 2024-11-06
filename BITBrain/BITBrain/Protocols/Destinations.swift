//
//  Destinations.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 25.10.24..
//

import Foundation

// MARK: - Protocol

protocol Destinations: Equatable, Hashable { }

// MARK: - Enums

enum AuthDestinations: Destinations {
    case register
}

enum ChatDestination: Destinations {
    case recentThreads
}

enum SettingsDestinations: Destinations {
    case profile
    case privacyPolicy
    case threadArchive
}
