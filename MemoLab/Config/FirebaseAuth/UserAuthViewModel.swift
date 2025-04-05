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
    @Published var userCanAccess: Bool = false
    @Published var hasError: Bool = false
    @Published var error: String = ""
    @Published var launchVerifyEmailModal: Bool = false
    
    func signUp(with credentials: UserCredentials) async {
        let result = await UserAuthRepository.signUp(with: credentials.email, and: credentials.password)
        switch result {
        case .success(let user):
            self.userAuth = user
            self.userCanAccess = user.emailIsVerified
            self.hasError = false
            self.error = ""
            self.launchVerifyEmailModal = !user.emailIsVerified
            await self.sendVerificationEmail()
        case .failure(let error):
            self.userAuth = nil
            self.userCanAccess = false
            self.hasError = true
            self.error = error.localizedDescription
            self.launchVerifyEmailModal = false
        }
    }
    
    func sendVerificationEmail() async {
        let result = await UserAuthRepository.sendVerificationEmail()
        switch result {
        case .success(_):
            self.launchVerifyEmailModal = true
        case .failure(_):
            self.launchVerifyEmailModal = false
        }
    }
    
    func isUserLoggedInAndVerified() async {
        guard let user = UserAuthRepository.isUserLoggedIn() else {
            return
        }
        self.userAuth = user
        self.userCanAccess = user.isAnonymous || user.emailIsVerified
    }
    
    func signInAnonymously() async {
        let result = await UserAuthRepository.signInAnonymously()
        switch result {
        case .success(let user):
            self.userAuth = user
            self.userCanAccess = true
            self.hasError = false
            self.error = ""
            self.launchVerifyEmailModal = false
        case .failure(let error):
            self.userAuth = nil
            self.userCanAccess = false
            self.hasError = true
            self.error = error.localizedDescription
            self.launchVerifyEmailModal = false
        }
    }
    
    func signIn(with credentials: UserCredentials) async {
        let result = await UserAuthRepository.signIn(with: credentials.email, and: credentials.password)
        switch result {
        case .success(let user):
            self.userAuth = user
            self.userCanAccess = user.emailIsVerified
            self.hasError = false
            self.error = ""
            self.launchVerifyEmailModal = !user.emailIsVerified
        case .failure(let error):
            self.userAuth = nil
            self.userCanAccess = false
            self.hasError = true
            self.error = error.localizedDescription
            self.launchVerifyEmailModal = false
        }
    }
    
    func signOut() async {
        let result = await UserAuthRepository.signOut()
        
        switch result {
        case .success(_):
            cleanAll()
        case .failure(let error):
            self.error = error.localizedDescription
        }
    }
    
    func cleanError() {
        self.hasError = false
        self.error = ""
    }
    
    private func cleanAll() {
        self.userAuth = nil
        self.userCanAccess = false
        self.cleanError()
        self.launchVerifyEmailModal = false
    }
    
}
