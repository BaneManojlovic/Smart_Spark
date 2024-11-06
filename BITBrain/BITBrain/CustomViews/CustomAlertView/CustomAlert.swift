//
//  CustomAlert.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 24.10.24..
//

import SwiftUI

struct CustomAlert {
    let title: String
    let message: String
    let primaryButton: Alert.Button
    let secundaryButton: Alert.Button
}

class AlertViewModel: ObservableObject {
    
    @Published var showAlert: Bool = false
    var alert: CustomAlert? = nil
    
    func presentAlert(alert: CustomAlert) {
        self.alert = alert
        self.showAlert = true
    }
}
