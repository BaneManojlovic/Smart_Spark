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
    var username: String?
    let email: String?
    let photoUrl: String?

    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case username = "user_name"
        case email = "user_email"
        case photoUrl = "profile_image"
        
    }
}
