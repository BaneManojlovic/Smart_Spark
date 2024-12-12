//
//  AuthService.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 26.10.24..
//

import Foundation
import OpenAI

final class AuthenticationManager {
    
    func login(email: String, password: String) async throws -> UserModel? {
//        let result = try await Auth.auth().signIn(withEmail: email, password: password)
//        return UserModel(user: result.user)
        return nil
    }
    
    func register(email: String, password: String) async throws -> UserModel?  {
//        let result = try await Auth.auth().createUser(withEmail: email, password: password)
//        return UserModel(user: result.user)
        return nil
    }
    
    func getAuthenticatedUser() throws -> UserModel? {
//        guard let user = Auth.auth().currentUser else { throw URLError(.unknown) }
//        return UserModel(user: user)
        return nil
    }
    
    func signOut() throws {
//        try Auth.auth().signOut()
        print("Sign out...")
    }
    
    // TODO: - Add this on Forgot passsword screen
    func resetPassword(email: String) async throws {
//        try await Auth.auth().sendPasswordReset(withEmail: email)
        print("Resset pass...")
    }
    // TODO: - Add this on Profile screen
    func updatePassword(password: String) async throws {
//        guard let user = Auth.auth().currentUser else { throw URLError(.unknown) }
//        try await user.updatePassword(to: password)
        print("Update pass...")
    }
    // TODO: - Add this on Profile screen
    func updateEmail(email: String) async throws {
//        guard let user = Auth.auth().currentUser else { throw URLError(.unknown) }
//        //'updateEmail(to:)' is deprecated: `updateEmail` is deprecated and will be removed in a future release. Use sendEmailVerification(beforeUpdatingEmail:) instead.
//        try await user.sendEmailVerification(beforeUpdatingEmail: email)
        print("Update email....")
    }
    // TODO: - Add this on Profile screen
    func deleteUser() async throws {
//        guard let user = Auth.auth().currentUser else { throw URLError(.unknown) }
//        try await user.delete()
        print("deleteUSer....")
    }
    
    // MARK: - Methods for database handling
    //    func createChat(user: String?) async throws -> String? {
    //        let document = try await database.collection("chats").addDocument(data: ["lastMessageSent": Date(), "owner": user ?? ""])
    //        return document.documentID
    //    }
    //
    //    func fetchData(user: String?) {
    //        database.collection("chats").whereField("owner", isEqualTo: user ?? "").addSnapshotListener { [weak self] querySnapshoot, error in
    //            guard let self = self else { return }
    //
    //            if let documents = querySnapshoot?.documents {
    //                // TODO: - finish this
    //            }
    //        }
    //    }
    //
    //    func storeMessage(message: AppMessage) throws -> DocumentReference {
    //        return try database.collection("chats").document(chatId).collection("message").addDocument(from: message)
    //    }
    //
    //    // TODO: - finish this
    //    private func setupNewChat() {
    ////        database.collection("chats").document(chatId).updateData(["model": selectedModel.rawValue])
    ////        DispatchQueue.main.async { [weak self] in
    ////            self.chat.model = self.selectedModel
    //        }
    //    }
    //// TODO: - finish this
    //    private func generateResponse(for message: AppMessage) async throws {
    ////        let openAI = OpenAI(apiToken: "")
    ////
    ////        let queryMessages = messages.map {
    ////
    //    }
    //
     
}

