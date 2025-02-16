//
//  UserAuthViewModel.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 16/2/25.
//

import SwiftUI

@MainActor
final class UserAuthViewModel: ObservableObject {
    @Published var userAuth: UserAuthModel?
    @Published var userLogged: Bool = false
    @Published var hasError: Bool = false
    @Published var error: String = ""
    
    func isUserLoggedIn() {
        guard let anonymousUser = UserAuthRepository.isAnonymousUserLoggedIn() else {
            return
        }
        self.userAuth = anonymousUser
        self.userLogged = true
    }
    func signInAnonymously() async {
        let result = await UserAuthRepository.signInAnonymously()
        switch result {
        case .success(let user):
            self.userAuth = user
            self.userLogged = true
            self.hasError = false
            self.error = ""
        case .failure(let error):
            self.userLogged = false
            self.hasError = true
            self.error = error.localizedDescription
        }
    }
    
    func signIn(with credentials: UserCredentials) async {
        let result = await UserAuthRepository.signIn(with: credentials.email, and: credentials.password)
        switch result {
        case .success(let user):
            self.userAuth = user
            self.userLogged = true
            self.hasError = false
            self.error = ""
        case .failure(let error):
            self.userLogged = false
            self.hasError = true
            self.error = error.localizedDescription
        }
    }
    
    func signOut() {
        let result = UserAuthRepository.signOut()
        
        switch result {
        case .success(let success):
            cleanAll()
        case .failure(let error):
            self.error = error.localizedDescription
        }
    }
    
    private func cleanAll() {
        userAuth = nil
        userLogged = false
        hasError = false
        error = ""
    }
}
