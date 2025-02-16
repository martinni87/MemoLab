//
//  UserAuthRepository.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 16/2/25.
//

import Foundation

struct UserAuthRepository {
    
    static func isAnonymousUserLoggedIn() -> UserAuthModel? {
        return UserAuthDataSource.isAnonymousUserLoggedIn()
    }
    
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
    
    static func signOut() -> Result<Bool, MLError> {
        do {
            try UserAuthDataSource.signOut()
            return .success(true)
        } catch {
            return .failure(MLError.invalidSignOut)
        }
    }
}
