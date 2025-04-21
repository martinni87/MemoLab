//
//  PreLoginButtonComponent.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 13/4/25.
//

import SwiftUI


struct PreLoginButton: View {
    
    private let imageResource: String
    private let localizedTextKey: String
    private let action: () -> Void
    
    init(image: String, text: String, action: @escaping () -> Void) {
        self.imageResource = image
        self.localizedTextKey = text
        self.action = action
    }
    
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(systemName: imageResource)
                Spacer()
                Text(localizedTextKey.localized)
                Spacer()
            }
            .applyMLButtonStyle(.prelogin)
        }
    }
}

struct PreLoginButtonsComponent: View {
    
    @ObservedObject var auth: UserAuthViewModel
    @StateObject private var viewModel = PreLoginViewModel()
    
    var body: some View {
        VStack {
            PreLoginButton(image: "person.fill.questionmark",
                           text: "prelogin.accessAnonymously.button") {
                viewModel.accessAnonymously.toggle()
            }
            PreLoginButton(image: "envelope.fill",
                           text: "prelogin.accessWithEmail.button") {
                viewModel.goToLoginView.toggle()
            }
            PreLoginButton(image: "person.fill.badge.plus",
                           text: "prelogin.createUser.button") {
                viewModel.goToRegisterView.toggle()
            }
        }
        .padding()
        .alert("alert.anonymous.title", isPresented: $viewModel.accessAnonymously) {
            Button("alert.anonymous.primary.button") {
                Task {
                    await auth.signInAnonymously()
                }
            }
            Button("alert.anonymous.cancel.button") {
                viewModel.accessAnonymously = false
            }
        } message: {
            Text("alert.anonymous.warning.message")
        }
        .navigationDestination(isPresented: $viewModel.goToLoginView) {
            LoginView(auth: auth)
        }
        .navigationDestination(isPresented: $viewModel.goToRegisterView) {
            RegisterView(auth: auth)
        }
    }
}

#Preview("Buttons set") {
    PreLoginButtonsComponent(auth: .init())
}
