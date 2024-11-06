//
//  Coordinator.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 25.10.24..
//

import SwiftUI

protocol Coordinator: ObservableObject {
    associatedtype CoordinatorDestinations: Destinations
    associatedtype CoordinatorView: View
    
    var path: [CoordinatorDestinations] { get set }
    
    func redirect(_ path: CoordinatorDestinations) -> CoordinatorView
}

