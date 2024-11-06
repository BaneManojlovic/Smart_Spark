//
//  User.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 31.10.24..
//

import Foundation
import FirebaseAuth

struct UserModel {
    let uid: String
    let email: String?
    let photoUrl: String?
    
    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
    }
}
