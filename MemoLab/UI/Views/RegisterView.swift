//
//  RegisterView.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 22/3/25.
//

import SwiftUI

struct RegisterView: View {
    
    @ObservedObject var auth: UserAuthViewModel
    @ObservedObject var data: DBViewModel
    @StateObject var form = RegisterFormViewModel()
    @State var verificationMailSent = true
    
    init(_ auth: UserAuthViewModel, _ data: DBViewModel) {
        self.auth = auth
        self.data = data
    }
    
    var body: some View {
        VStack(spacing: 30) {
            Text("register.createNewUser.title")
                .font(.largeTitle)
                .bold()
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
                MLTextFieldViewComponent(
                    label: form.repeatPasswordField.label,
                    text: $form.repeatPasswordField.text,
                    error: $form.repeatPasswordField.error,
                    isSecure: true,
                    isHidden: true)
            }
            Spacer()
            HStack(spacing: 10) {
                Button {
                    form.validate()
                } label: {
                    Text("form.createUser.button")
                        .applyMLButtonStyle(height: 80)
                }
                Button {
                    form.cleanFields()
                } label: {
                    Text("form.clean.button")
                        .applyMLButtonStyle(.secondary, height: 80)
                }
            }
        }
        .padding()
        .sheet(isPresented: $verificationMailSent, onDismiss: {
            form.cleanFields()
            verificationMailSent = false
        }, content: {
            RegisterVerificationView(auth, data, form)
                .interactiveDismissDisabled(true)
        })
        .onChange(of: form.isValid) { _, _ in
            form.sendVerificationCode()
            verificationMailSent = true
        }
        /*
         Task {
         await auth.signUp(with: formVM.credentials)
         }
         */
    }
}

#Preview {
    RegisterView(.init(), .init())
}
