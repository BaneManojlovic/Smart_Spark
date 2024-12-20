//
//  UserManager.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 28.11.24..
//

import Foundation

//final class UserDataManager {
//    
//    static let shared = UserDataManager() // Singleton
//    
//    private init() { }
//
//    func createNewUser(model: UserModel) async throws {
//        var userData: [String: Any] = [
//            "user_id" : model.uid,
//            "date_created" : Timestamp(),
//            "email" : model.email ?? ""
//         ]
//        
//        if let email = model.email{
//            userData["email"] = email
//        }
//
//        if let photoUrl = model.photoUrl {
//            userData["photo_url"] = photoUrl
//        }
//        
//        if let userName = model.username {
//            userData["user_name"] = userName
//        }
//
//        try await database.collection("users").document("\(model.uid)").setData(userData)
//    }
//}
