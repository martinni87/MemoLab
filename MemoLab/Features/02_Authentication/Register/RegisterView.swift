//
//  RegisterView.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 22/3/25.
//

import SwiftUI

struct RegisterView: View {
    
    @ObservedObject var auth: UserAuthViewModel
    @StateObject var form = RegisterFormViewModel()
    
    var body: some View {
            VStack(spacing: 10) {
                Text("register.createNewUser.title")
                    .font(.largeTitle)
                    .fontWeight(.black)
                Spacer()
                VStack(spacing: 0){
                    MLTextFieldViewComponent(
                        label: form.emailField.label,
                        hint: form.emailField.hint,
                        text: $form.emailField.text,
                        error: $form.emailField.error)
                    .keyboardType(.emailAddress)
                    MLTextFieldViewComponent(
                        label: form.passwordField.label,
                        text: $form.passwordField.text,
                        error: $form.passwordField.error,
                        isSecure: true,
                        isHidden: true,
                        hasInfo: true,
                        infoMessage: "form.info.passwordFormat")
                    MLTextFieldViewComponent(
                        label: form.repeatPasswordField.label,
                        text: $form.repeatPasswordField.text,
                        error: $form.repeatPasswordField.error,
                        isSecure: true,
                        isHidden: true)
                }
                Spacer()
                VStack {
                    Button {
                        form.validate()
                    } label: {
                        Text("form.createUser.button")
                            .applyMLButtonStyle()
                    }
                    Button {
                        form.cleanFields()
                    } label: {
                        Text("form.clean.button")
                            .applyMLButtonStyle(.link)
                    }
                }
            }
            .padding()
            .applyFixedFrameSize()
            .sheet(isPresented: $auth.launchVerifyEmailModal, onDismiss: {
                form.cleanFields()
                Task {
                    await auth.signOut()
                }
            }, content: {
//                EmailVerificationModal(auth, data, form)
                EmailVerificationModal(auth: auth, form: form)
                    .interactiveDismissDisabled(true)
            })
            .onChange(of: form.isValid) { _, _ in
                if form.isValid {
                    Task {
                        await auth.signUp(
                            with: .init(email: form.emailField.text,
                                        password: form.passwordField.text))
                    }
                }
            }
            .alert("alert.error.title", isPresented: $auth.hasError) {
                Button("alert.primary.button") {
                    form.isValid = false
                    auth.cleanError()
                }
            } message: {
                Text("alert.error.register.message")
            }
    }
}

#Preview {
    RegisterView(auth: .init())
}
