//
//  UIAplication+Extension.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 17.12.24..
//

import UIKit

extension UIApplication {
    func endEditing(_ force: Bool) {
        guard let windowScene = self.connectedScenes.first as? UIWindowScene else { return }
        windowScene.windows
            .first { $0.isKeyWindow }?
            .endEditing(force)
    }
}
