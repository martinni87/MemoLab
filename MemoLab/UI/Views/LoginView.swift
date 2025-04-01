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
                        await auth.signIn(with: UserCredentials(email: form.emailField.text, password: form.passwordField.text))
                    }
                }
            }
            .padding()
            .alert("alert.error.title", isPresented: $auth.hasError) {
                Button("alert.primary.button") {
                    
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


//struct LoginView: View {
//    @ObservedObject var auth: UserAuthViewModel
//    @ObservedObject var data: DBViewModel
////    @StateObject var emailVM = TextFieldViewModel(TextFieldData(label: "form.email.label", hint: "form.email.hint", isMandatory: true, regexToCheck: EMAIL_PATTERN))
////    @StateObject var passwordVM = TextFieldViewModel(TextFieldData(label: "form.password.label", isSecure: true, isHidden: true, isMandatory: true))
//    @State var anonymousLogin = false
//    @State var createNewUser = false
//
//    init(_ auth: UserAuthViewModel, _ data: DBViewModel) {
//        self.auth = auth
//        self.data = data
//    }
//
//    var body: some View {
//        NavigationStack {
//            ScrollView {
//                Text("form.login.title").font(.largeTitle).fontWeight(.black)
//                    .padding(30)
//                Divider()
//                VStack(spacing: 10) {
////                    Group {
////                        TextFieldViewComponent(emailVM)
////                        TextFieldViewComponent(passwordVM)
////                    }
////                    .textInputAutocapitalization(.never)
////                    .autocorrectionDisabled()
//                    Button {
////                        emailVM.validate()
////                        passwordVM.validate()
//                    } label: {
//                        Text("form.login.button")
//                            .applyMLButtonStyle(width: 200)
//                    }
//                    NavigationLink("form.login.forgotPassword.navigationLink") {
//                        RecoverPasswordView()
//                    }
//                    .applyMLButtonStyle(.link)
//                }
//                .padding(.horizontal, 1)
//                .padding(.vertical, 30)
//                Divider()
//                    .foregroundStyle(.accent)
//                Button {
//                    anonymousLogin = true
//                } label: {
//                    Text("form.login.anonymously.button")
//                        .applyMLButtonStyle(.secondary, width: 200)
//                }
//                .padding(.vertical, 30)
//                Divider()
//                VStack(spacing: 0) {
//                    Text("form.login.notRegistered.label").padding(.vertical, 0)
//                    NavigationLink("form.login.newUser.link") {
//                        CreateNewUserView(auth, data)
//                    }
//                    .applyMLButtonStyle(.link)
//                    .padding(.vertical, 0)
//                }
//                .padding(.vertical, 30)
//            }
//            .scrollIndicators(.never)
//            .scrollDisabled(true)
//            .padding()
//            .navigationTitle("form.login.title")
//            .toolbarVisibility(.hidden, for: .navigationBar)
//            .alert("alert.anonymous.title", isPresented: $anonymousLogin) {
//                Button("alert.anonymous.primary.button") {
//                    Task {
//                        await auth.signInAnonymously()
//                    }
//                }
//                Button("alert.anonymous.cancel.button") {
//                    anonymousLogin = false
//                }
//            } message: {
//                Text("alert.anonymous.warning.message")
//            }
//            .alert("alert.error.title", isPresented: $auth.hasError) {
//                Button("alert.primary.button") {
////                    emailVM.textFieldIsValid = false
////                    passwordVM.textFieldIsValid = false
//                }
//            } message: {
//                Text("alert.error.login.message")
//            }
////            .onChange(of: (emailVM.textFieldIsValid && passwordVM.textFieldIsValid)) { _, _ in
////                if emailVM.textFieldIsValid && passwordVM.textFieldIsValid {
////                    Task {
////                        await auth.signIn(with: UserCredentials(email: emailVM.data.text, password: passwordVM.data.text))
////                        if auth.userLogged {
//////                            emailVM.resetAll()
//////                            passwordVM.resetAll()
////                        }
////                    }
////                }
////            }
//            .fullScreenCover(isPresented: $auth.userLogged) {
//                MainView(auth, data)
//            }
//        }
//    }
//}
//
////final class LoginViewModel: ObservableObject {
////    @ObservedObject var emailVM: TextFieldViewModel
////    @ObservedObject var passwordVM: TextFieldViewModel
////
////    init(_ emailVM: TextFieldViewModel, _ passwordVM: TextFieldViewModel) {
////        self.emailVM = emailVM
////        self.passwordVM = passwordVM
////    }
////
////    func isValid() {
////
////    }
////}
//
//
//#Preview("LoginView") {
//    LoginView(.init(), .init())
//}
