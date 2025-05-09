//
//  UserAuthDataSource.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 16/2/25.
//

import Foundation
import FirebaseAuth
import Firebase

struct UserAuthDataSource {
    
    private static let authFB = Auth.auth()
    
    static func signUp(with email: String, and password: String) async throws -> UserAuthModel {
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            return UserAuthModel(id: authResult.user.uid,
                                 name: authResult.user.displayName ?? "userAuth.name.unknown",
                                 email: email,
                                 isAnonymous: false,
                                 emailIsVerified: authResult.user.isEmailVerified)
        } catch {
            throw MLError.invalidSignUp
        }
    }
    
    static func sendVerificationEmail() async throws -> Bool {
        do {
            guard let user = Auth.auth().currentUser else {
                throw MLError.noUserCached
            }
            try await user.sendEmailVerification()
            return true
        } catch {
            throw MLError.resendVerificationEmail
        }
    }
    
    static func isUserLoggedIn() async throws -> UserAuthModel? {
        
        guard let cachedUser = Auth.auth().currentUser else {
            Logger.info("Cached User not found")
            return nil
        }
        
        if cachedUser.isAnonymous {
            try await signOut()
        }
        
        do {
            let _ = try await cachedUser.getIDTokenResult(forcingRefresh: true)
            return UserAuthModel(
                id: cachedUser.uid,
                name: cachedUser.displayName ?? "userAuth.name.unknown".localized,
                email: cachedUser.email ?? "",
                isAnonymous: cachedUser.isAnonymous,
                emailIsVerified: cachedUser.isEmailVerified
            )
        } catch {
            Logger.error("User token invalid or expired for uid: \(cachedUser.uid). Error: \(error.localizedDescription)")
            throw MLError.invalidSignIn
        }
    }
    
    static func signInAnonymously() async throws -> UserAuthModel {
        do {
            let authResult = try await Auth.auth().signInAnonymously()
            return UserAuthModel(id: authResult.user.uid,
                                 name: "userAuth.name.anonymous".localized,
                                 email: "",
                                 isAnonymous: true,
                                 emailIsVerified: authResult.user.isEmailVerified)
        } catch {
            throw MLError.invalidSignIn
        }
    }
    
    static func signIn(with email: String, and password: String) async throws -> UserAuthModel {
        do {
            let authResult = try await Auth.auth().signIn(withEmail: email, password: password)
            return UserAuthModel(id: authResult.user.uid,
                                 name: authResult.user.displayName ?? "userAuth.name.unknown",
                                 email: email,
                                 isAnonymous: false,
                                 emailIsVerified: authResult.user.isEmailVerified
            )
        } catch {
            throw MLError.invalidSignIn
        }
        
    }
    
    static func signOut() async throws {
        if Auth.auth().currentUser!.isAnonymous {
            do {
                try await Auth.auth().currentUser?.delete()
            } catch {
                Logger.info("Anonymous Cached User no longer exists in Firebase")
            }
        }
        try Auth.auth().signOut()
    }
}
