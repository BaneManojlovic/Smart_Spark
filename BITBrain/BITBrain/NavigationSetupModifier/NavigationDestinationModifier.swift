//
//  NavigationDestinationModifier.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 25.10.24..
//

import Foundation
import UIKit
import SwiftUI

struct NavigationDestinationModifier<CoordinatorType: Coordinator>: ViewModifier {
    
    @ObservedObject var coordinator: CoordinatorType
    
    func body(content: Content) -> some View {
        NavigationStack(path: $coordinator.path) {
            content
                .navigationDestination(for: CoordinatorType.CoordinatorDestinations.self) { destination in
                    print("Navigate to \(destination)")
                    return coordinator.redirect(destination)
                }
        }
    }
}

extension View {
    func applyNavigation<CoordinatorType: Coordinator>(coordinator: CoordinatorType) -> some View {
        self.modifier(NavigationDestinationModifier(coordinator: coordinator))
    }
}
