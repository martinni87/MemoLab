//
//  LoginView.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 16/2/25.
//

import SwiftUI

struct LoginView: View {
    
    @ObservedObject var auth: UserAuthViewModel
    @ObservedObject var data: DBViewModel
    @StateObject var form = LoginFormViewModel()
    
    init(_ auth: UserAuthViewModel, _ data: DBViewModel) {
        self.auth = auth
        self.data = data
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("form.login.title")
                    .font(.largeTitle)
                    .fontWeight(.black)
                Spacer()
                VStack(spacing: 0){
                    MLTextFieldViewComponent(
                        label: form.emailField.label,
                        hint: form.emailField.hint,
                        text: $form.emailField.text,
                        error: $form.emailField.error)
                    MLTextFieldViewComponent(
                        label: form.passwordField.label,
                        text: $form.passwordField.text,
                        error: $form.passwordField.error,
                        isSecure: true,
                        isHidden: true)
                    NavigationLink("form.login.forgotPassword.navigationLink") {
                        RecoverPasswordView()
                    }
                    .applyMLButtonStyle(.link)
                }
                Spacer()
                Button {
                    form.validate()
                } label: {
                    Text("form.login.button")
                        .applyMLButtonStyle()
                }
                Spacer()
            }
            .onChange(of: form.isValid) { _, _ in
                if form.isValid {
                    Task {
                        await auth.signIn(with:
                                            UserCredentials(
                                                email: form.emailField.text,
                                                password: form.passwordField.text))
                    }
                }
            }
            .padding()
            .sheet(isPresented: $auth.launchVerifyEmailModal, onDismiss: {
                form.cleanFields()
                Task {
                    await auth.signOut()
                }
            }, content: {
                EmailVerificationModal(auth, data, form)
                    .interactiveDismissDisabled(true)
            })
            .alert("alert.error.title", isPresented: $auth.hasError) {
                Button("alert.primary.button") {
                    form.isValid = false
                    auth.hasError = false
                }
            } message: {
                Text("alert.error.login.message")
            }
        }
    }
}

#Preview {
    LoginView(.init(), .init())
}
