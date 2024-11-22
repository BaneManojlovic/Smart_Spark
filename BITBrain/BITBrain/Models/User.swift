//
//  User.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 31.10.24..
//

import Foundation
import FirebaseAuth

struct UserModel: Codable {
    let uid: String
    let email: String?
    let photoUrl: String?
    let password: String?

    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
        self.password = ""
    }
}
