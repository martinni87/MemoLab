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
            return UserAuthModel(id: authResult.user.uid, isAnonymous: false, name: authResult.user.email ?? "Desconocido")
        } catch {
            throw MLError.invalidSignUp
        }
    }
    
    static func signUpWithVerification(with email: String, and password: String) async throws -> UserAuthModel {
        do {
            let authResult = try await Auth.auth().createUser(withEmail: email, password: password)
            try await authResult.user.sendEmailVerification()
            return UserAuthModel(id: authResult.user.uid, isAnonymous: false, name: authResult.user.email ?? "Desconocido")
        } catch {
            throw MLError.invalidSignUp
        }
    }
    
    static func isAnonymousUserLoggedIn() -> UserAuthModel? {
        guard let user = Auth.auth().currentUser else {
            return nil
        }
        return UserAuthModel(id: user.uid, isAnonymous: user.isAnonymous, name: user.displayName ?? "Anónimo")
    }

    static func signInAnonymously() async throws -> UserAuthModel {
        do {
            let authResult = try await Auth.auth().signInAnonymously()
            return UserAuthModel(id: authResult.user.uid,
                                 isAnonymous: authResult.user.isAnonymous,
                                 name: authResult.user.displayName ?? "Anónimo")
        } catch {
            throw MLError.invalidSignIn
        }
    }
    
    static func singIn(with email: String, and password: String) async throws -> UserAuthModel {
        do {
            let userData = try await Auth.auth().signIn(withEmail: email, password: password)
            return UserAuthModel(id: userData.user.uid, isAnonymous: false, name: userData.user.displayName ?? "Desconocido")
        } catch {
            throw MLError.invalidSignIn
        }
        
    }
    
    static func signOut() throws {
        try Auth.auth().signOut()
    }
}
