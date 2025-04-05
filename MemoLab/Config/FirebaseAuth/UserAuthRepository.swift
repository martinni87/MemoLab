//
//  UserAuthRepository.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 16/2/25.
//

import Foundation

struct UserAuthRepository {
    
    static func signUp(with email: String, and password: String) async -> Result<UserAuthModel, MLError> {
        do {
            let user = try await UserAuthDataSource.signUp(with: email, and: password)
            return .success(user)
        } catch let error as MLError {
            return .failure(error)
        } catch {
            return .failure(MLError.unknown)
        }
    }
    
    static func sendVerificationEmail() async -> Result<Bool, MLError> {
        do {
            let emailSent = try await UserAuthDataSource.sendVerificationEmail()
            return .success(emailSent)
        } catch let error as MLError {
            return .failure(error)
        } catch {
            return .failure(MLError.unknown)
        }
    }
    
    static func isUserLoggedIn() -> UserAuthModel? {
        return UserAuthDataSource.isUserLoggedIn()
    }
//    
//    static func isUserVerified() -> Bool {
//        return UserAuthDataSource.isUserVerified()
//    }
    
    static func signInAnonymously() async -> Result<UserAuthModel, MLError> {
        do {
            let result = try await UserAuthDataSource.signInAnonymously()
            return .success(result)
        } catch let error as MLError {
            return .failure(error)
        } catch {
            return .failure(MLError.unknown)
        }
    }
    
    static func signIn(with email: String, and password: String) async -> Result<UserAuthModel, MLError> {
        do {
            let user = try await UserAuthDataSource.singIn(with: email, and: password)
            return .success(user)
        } catch let error as MLError {
            return .failure(error)
        } catch {
            return .failure(.unknown)
        }
    }
    
    static func signOut() async -> Result<Bool, MLError> {
        do {
            try await UserAuthDataSource.signOut()
            return .success(true)
        } catch {
            return .failure(MLError.invalidSignOut)
        }
    }
}
