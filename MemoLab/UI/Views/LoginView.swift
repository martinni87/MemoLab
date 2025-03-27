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
    @StateObject var emailVM = TextFieldViewModel(TextFieldData(label: "form.email.label", hint: "form.email.hint", isMandatory: true, regexToCheck: EMAIL_PATTERN))
    @StateObject var passwordVM = TextFieldViewModel(TextFieldData(label: "form.password.label", isSecure: true, isHidden: true, isMandatory: true))
    @State var anonymousLogin = false
    @State var createNewUser = false
    
    init(_ auth: UserAuthViewModel, _ data: DBViewModel) {
        self.auth = auth
        self.data = data
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 30) {
                Text("form.login.title").font(.largeTitle).fontWeight(.black)
                Divider()
                VStack(spacing: 10) {
                    TextFieldViewComponent(emailVM)
                    TextFieldViewComponent(passwordVM)
                    Button("form.login.button") {
                        emailVM.validate()
                        passwordVM.validate()
                    }
                    .applyMLButtonStyle()
                    NavigationLink("form.login.forgotPassword.navigationLink") {
                        RecoverPasswordView()
                    }
                    .applyMLButtonStyle(.link)
                }
                Divider()
                Button("form.login.anonymously.button") {
                    anonymousLogin = true
                }
                .applyMLButtonStyle(.secondary)
                Divider()
                VStack {
                    Text("form.login.notRegistered.label")
                    NavigationLink("form.login.newUser.link") {
                        CreateNewUserView()
                    }
                    .applyMLButtonStyle(.link)
                }
            }
            .padding()
            .navigationTitle("form.login.title")
            .toolbarVisibility(.hidden, for: .navigationBar)
            .alert("alert.anonymous.title", isPresented: $anonymousLogin) {
                Button("alert.anonymous.primary.button") {
                    Task {
                        await auth.signInAnonymously()
                    }
                }
                Button("alert.anonymous.cancel.button") {
                    anonymousLogin = false
                }
            } message: {
                Text("alert.anonymous.warning.message")
            }
            .alert("alert.error.title", isPresented: $auth.hasError) {
                Button("alert.primary.button") {
                    emailVM.textFieldIsValid = false
                    passwordVM.textFieldIsValid = false
                }
            } message: {
                Text("alert.error.login.message")
            }
            .onChange(of: (emailVM.textFieldIsValid && passwordVM.textFieldIsValid)) { _, _ in
                if emailVM.textFieldIsValid && passwordVM.textFieldIsValid {
                    Task {
                        await auth.signIn(with: UserCredentials(email: emailVM.data.text, password: passwordVM.data.text))
                        if auth.userLogged {
                            emailVM.resetAll()
                            passwordVM.resetAll()
                        }
                    }
                }
            }
            .fullScreenCover(isPresented: $auth.userLogged) {
                MainView(auth, data)
            }
        }
    }
}

final class LoginViewModel: ObservableObject {
    @ObservedObject var emailVM: TextFieldViewModel
    @ObservedObject var passwordVM: TextFieldViewModel
    
    init(_ emailVM: TextFieldViewModel, _ passwordVM: TextFieldViewModel) {
        self.emailVM = emailVM
        self.passwordVM = passwordVM
    }
    
    func isValid() {
        
    }
}


#Preview("LoginView") {
    LoginView(.init(), .init())
}
