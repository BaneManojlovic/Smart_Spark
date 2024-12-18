//
//  AuthService.swift
//  BITBrain
//
//  Created by Branislav Manojlovic on 26.10.24..
//

import Foundation
import Observation
import OpenAI
import Supabase
import SwiftUI


extension SupabaseClient {

    static var client: SupabaseClient {
        SupabaseClient(supabaseURL: URL(string: "https://fafxozxpyqeziargccre.supabase.co")!,
                       supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZhZnhvenhweXFlemlhcmdjY3JlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM5OTU5NzEsImV4cCI6MjA0OTU3MTk3MX0.Wv9zJhaJ-nT2uKPRK1f_L4qVoZOM_E2YyGEspJgAoXk")
    }
}

@Observable
class AuthenticationManager {

    static let shared = AuthenticationManager()
    let authClient = SupabaseClient.client.auth
    let databaseClient = SupabaseClient.client
    
    init() {}
    
    func login(email: String, password: String) async -> Bool {
        do {
            try await authClient.signIn(email: email, password: password)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }

    func getAuthenticatedUser() async -> UserModel? {
        do {
            let user = try await authClient.user()
            return UserModel(from: user)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }

    func register(email: String, password: String) async -> Bool {
        do {
            let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
            try await authClient.signUp(email: trimmedEmail, password: password)
            return true
        } catch {
            print(error.localizedDescription)
            return false
        }
    }
    
    func saveUser(user: UserModel, completion: @escaping (Error?) -> Void) async {
        do {
            try await databaseClient.from("profiles").insert(user).execute()
            completion(nil)
        } catch {
            debugPrint(error.localizedDescription)
            completion(error)
        }
    }

    func getUserData(userId: UUID) async -> UserModel? {
        print("\(userId)")
        do {
            let response: [UserModel] = try await databaseClient.from("profiles").select().eq("id",
                                                                                              value: userId.uuidString.lowercased()).execute().value
            print("\(response)")
            return response.first
        } catch {
            print("error")
            return nil
        }
    }

    func signOut() async {
        do {
            try await authClient.signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteUser(userId: UUID) async throws {
        let userIdString = userId.uuidString.lowercased()
        do {
            try await databaseClient.from("profiles").delete().eq("id", value: userIdString).execute()
            print("user deleted...")
        } catch {
            print("failure ...")
        }
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
}

