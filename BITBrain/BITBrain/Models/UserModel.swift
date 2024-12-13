//
//  User.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 31.10.24..
//

import Foundation
import Supabase

struct UserModel: Codable {
    let id: UUID
    let email: String?
    let photoUrl: String?
    var username: String?

    init(from supabaseUser: User) {
        self.id = supabaseUser.id
        self.email = supabaseUser.email
        self.photoUrl = supabaseUser.userMetadata["photoUrl"]?.stringValue
        self.username = supabaseUser.userMetadata["username"]?.stringValue
    }

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case email = "user_email"
        case photoUrl = "profile_image"
        case username = "user_name"
    }
}
