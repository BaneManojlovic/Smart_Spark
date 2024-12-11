//
//  CustomAlert.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 24.10.24..
//

import SwiftUI
// Da li ovo moze da se napravi kao weak ?
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
        DispatchQueue.main.async {
            self.alert = alert
            self.showAlert = true
        }
    }
}
