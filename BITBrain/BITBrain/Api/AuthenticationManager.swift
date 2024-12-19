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
    let authClient = SupabaseClient.client.auth        // needed for authentification meaning register, login, logout, delete account
    let databaseClient = SupabaseClient.client         // needed for saving all types of data to tables in database
    let storageClient = SupabaseClient.client.storage  // needed for saving images, documents, .. etc to storage
    
    init() {}
    
    func login(email: String, password: String) async -> Bool {
        print("Bane - called login(email: String, password: String)")
        do {
            try await authClient.signIn(email: email, password: password)
            return true
        } catch {
            print("Bane - error == ", error.localizedDescription)
            return false
        }
    }
    /// method for checking does authenticated user exists on supabase database
    func getAuthenticatedUser() async -> UUID? {
        print("Bane - called getAuthenticatedUser()")
        do {
            let user = try await authClient.user() /// returns User object form supabase database that is different form UserModel - mapping is needed
            print("Bane - user postoji = \(String(describing: user.email))")
            return user.id
        } catch {
            print("Bane - error = ", error.localizedDescription)
            return nil
        }
    }

    func register(email: String, password: String) async -> Bool {
        print("Bane - called register(email: String, password: String)")
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
        print("Bane - called saveUserToDatabase(user: UserModel, completion: @escaping (Error?) -> Void) ")
        do {
            try await databaseClient.from("profiles").insert(user).execute()
            completion(nil)
        } catch {
            debugPrint(error.localizedDescription)
            completion(error)
        }
    }
    
    func updateUserDataInDatabase(user: UserModel, completion: @escaping (Error?) -> Void) async {
        print("Bane - called saveUserToDatabase(user: UserModel, completion: @escaping (Error?) -> Void) ")
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
        print("Bane - called getUserDataFromDatabase(user: UserModel, completion: @escaping (Error?) -> Void) ")
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
    
    func deleteUserFromDatabase(userId: UUID) async throws {
        let userIdString = userId.uuidString.lowercased()
        do {
            try await databaseClient.from("profiles").delete().eq("id", value: userIdString).execute()
            print("user deleted...")
        } catch {
            print("failure ...")
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
            print("error...error")
        }
        
        return imagePath
    }

    func downloadImage(path: String) async -> AvatarImage? {
        
        
        
//        let baki = "private/15288671-6609-4F73-B51C-42B497713E4E.png"
        //15288671-6609-4F73-B51C-42B497713E4E.png
        do {
            let data = try await storageClient.from("photos").download(path: path)
            print("Bane - data = \(data)")
            return AvatarImage(data: data)
        } catch {
            print("error")
            return nil
        }
    }
}

