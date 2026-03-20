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

// MARK: - Protocol

/// Defines all authentication and data operations performed against Supabase.
/// ViewModels depend on this protocol, not the concrete class, so tests can
/// inject a mock without touching any real network code.
protocol AuthenticationManagerProtocol: AnyObject {
    func login(email: String, password: String) async -> Bool
    func getAuthenticatedUser() async -> UUID?
    func register(email: String, password: String) async -> Bool
    func saveUserToDatabase(user: UserModel, completion: @escaping (Error?) -> Void) async
    func updateUserDataInDatabase(user: UserModel, completion: @escaping (Error?) -> Void) async
    func getUserDataFromDatabase(userId: UUID) async -> UserModel?
    func signOut() async
    func deleteUserFromDatabase(userId: UUID) async throws
    func saveAndUploadUserProfileImage(avatarImageData: Data) async throws -> String?
    func downloadImage(path: String) async throws -> AvatarImage?
}

// MARK: - Supabase client factory

extension SupabaseClient {

    static var client: SupabaseClient {
        SupabaseClient(supabaseURL: URL(string: "https://fafxozxpyqeziargccre.supabase.co")!,
                       supabaseKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImZhZnhvenhweXFlemlhcmdjY3JlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzM5OTU5NzEsImV4cCI6MjA0OTU3MTk3MX0.Wv9zJhaJ-nT2uKPRK1f_L4qVoZOM_E2YyGEspJgAoXk")
    }
}

// MARK: - Concrete implementation

@Observable
class AuthenticationManager: AuthenticationManagerProtocol {

    static let shared = AuthenticationManager()
    let authClient = SupabaseClient.client.auth        // needed for authentification meaning register, login, logout, delete account
    let databaseClient = SupabaseClient.client         // needed for saving all types of data to tables in database
    let storageClient = SupabaseClient.client.storage  // needed for saving images, documents, .. etc to storage
    
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
    /// method for checking does authenticated user exists on supabase database
    func getAuthenticatedUser() async -> UUID? {
        do {
            let user = try await authClient.user() /// returns User object form supabase database that is different form UserModel - mapping is needed
            return user.id
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
    
    /// method for saving user into "profiles" data table in supabase database
    func saveUserToDatabase(user: UserModel, completion: @escaping (Error?) -> Void) async {
        do {
            try await databaseClient.from("profiles").insert(user).execute()
            completion(nil)
        } catch {
            debugPrint(error.localizedDescription)
            completion(error)
        }
    }
    
    func updateUserDataInDatabase(user: UserModel, completion: @escaping (Error?) -> Void) async {
        do {
            try await databaseClient.from("profiles").update(user).eq("id", value: user.id).execute()
            completion(nil)
        } catch {
            debugPrint(error.localizedDescription)
            completion(error)
        }
    }

    /// method for getting user data from table "profile" saved on supabase database
    func getUserDataFromDatabase(userId: UUID) async -> UserModel? {
        do {
            let response: [UserModel] = try await databaseClient.from("profiles").select().eq("id",
                                                                                              value: userId.uuidString.lowercased()).execute().value
            return response.first
        } catch {
            print(error.localizedDescription)
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
    
    func deleteUserFromDatabase(userId: UUID) async throws {
        let userIdString = userId.uuidString.lowercased()
        do {
            try await databaseClient.from("profiles").delete().eq("id", value: userIdString).execute()
            print("user deleted...")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveAndUploadUserProfileImage(avatarImageData: Data) async throws -> String? {
        
        var imagePath: String?
        let uniqueFileName = UUID().uuidString
        
        do {
            let response = try await storageClient
                .from("photos")
                .upload("private/\(uniqueFileName).png",
                        data: avatarImageData,
                        options: FileOptions(
                        cacheControl: "3600",
                        contentType: "image/png",
                        upsert: false)
                )
            imagePath = response.path
        } catch {
            print(error.localizedDescription)
        }
        
        return imagePath
    }

    func downloadImage(path: String) async throws -> AvatarImage? {
        do {
            let data = try await storageClient.from("photos").download(path: path)
            return AvatarImage(data: data)
        } catch {
            print(error.localizedDescription)
            return nil
        }
    }
}

