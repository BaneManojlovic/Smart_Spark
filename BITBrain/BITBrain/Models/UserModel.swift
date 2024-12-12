//
//  User.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 31.10.24..
//

import Foundation

struct UserModel: Codable {
    let uid: String
    let email: String?
    let photoUrl: String?
    let password: String?
    var username: String?

    init(uid: String, email: String, photoUrl: String, password: String, username: String) {
        self.uid = uid
        self.email = email
        self.photoUrl = photoUrl
        self.password = password
        self.username = username
    }

    init(user: UserModel) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoUrl
        self.password = ""
        self.username = user.username
    }
}
