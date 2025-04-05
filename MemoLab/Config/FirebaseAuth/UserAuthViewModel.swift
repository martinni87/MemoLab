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
    @Published var isWaitingResponse: Bool = false
    
    func signUp(with credentials: UserCredentials) async {
        self.isWaitingResponse = true
        let result = await UserAuthRepository.signUp(with: credentials.email, and: credentials.password)
        switch result {
        case .success(let user):
            self.userAuth = user
            self.userCanAccess = user.emailIsVerified
            self.hasError = false
            self.error = ""
            self.launchVerifyEmailModal = !user.emailIsVerified
            await self.sendVerificationEmail()
            self.isWaitingResponse = false
        case .failure(let error):
            self.userAuth = nil
            self.userCanAccess = false
            self.hasError = true
            self.error = error.localizedDescription
            self.launchVerifyEmailModal = false
            self.isWaitingResponse = false
        }
    }
    
    func sendVerificationEmail() async {
        self.isWaitingResponse = true
        let result = await UserAuthRepository.sendVerificationEmail()
        switch result {
        case .success(_):
            self.launchVerifyEmailModal = true
            self.isWaitingResponse = false
        case .failure(_):
            self.launchVerifyEmailModal = false
            self.isWaitingResponse = false
        }
    }
    
    func isUserLoggedInAndVerified() async {
        self.isWaitingResponse = true
        guard let user = UserAuthRepository.isUserLoggedIn() else {
            self.isWaitingResponse = false
            return
        }
        self.userAuth = user
        self.userCanAccess = user.isAnonymous || user.emailIsVerified
        self.isWaitingResponse = false
    }
    
    func signInAnonymously() async {
        self.isWaitingResponse = true
        let result = await UserAuthRepository.signInAnonymously()
        switch result {
        case .success(let user):
            self.userAuth = user
            self.userCanAccess = true
            self.hasError = false
            self.error = ""
            self.launchVerifyEmailModal = false
            self.isWaitingResponse = false
        case .failure(let error):
            self.userAuth = nil
            self.userCanAccess = false
            self.hasError = true
            self.error = error.localizedDescription
            self.launchVerifyEmailModal = false
            self.isWaitingResponse = false
        }
    }
    
    func signIn(with credentials: UserCredentials) async {
        self.isWaitingResponse = true
        let result = await UserAuthRepository.signIn(with: credentials.email, and: credentials.password)
        switch result {
        case .success(let user):
            self.userAuth = user
            self.userCanAccess = user.emailIsVerified
            self.hasError = false
            self.error = ""
            self.launchVerifyEmailModal = !user.emailIsVerified
            self.isWaitingResponse = false
        case .failure(let error):
            self.userAuth = nil
            self.userCanAccess = false
            self.hasError = true
            self.error = error.localizedDescription
            self.launchVerifyEmailModal = false
            self.isWaitingResponse = false
        }
    }
    
    func signOut() async {
        self.isWaitingResponse = true
        let result = await UserAuthRepository.signOut()
        
        switch result {
        case .success(_):
            cleanAll()
        case .failure(let error):
            self.error = error.localizedDescription
            self.isWaitingResponse = false
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
        self.isWaitingResponse = false
    }
    
}
