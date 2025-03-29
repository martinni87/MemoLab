//
//  CreateNewUserView.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 22/3/25.
//

import SwiftUI

struct CreateNewUserView: View {
    
    @ObservedObject var auth: UserAuthViewModel
    @ObservedObject var data: DBViewModel
    
    @StateObject var nameVM = TextFieldViewModel(TextFieldData(label: "form.name.label", hint: "form.name.hint", text: "", isMandatory: true))
    @StateObject var emailVM = TextFieldViewModel(TextFieldData(label: "form.email.label", hint: "form.email.hint", isMandatory: true, regexToCheck: EMAIL_PATTERN))
    @StateObject var passwordVM = TextFieldViewModel(TextFieldData(label: "form.password.label", isSecure: true, isHidden: true, isMandatory: true))
    @StateObject var repeatPasswordVM = TextFieldViewModel(TextFieldData(label: "form.repeatPassword.label", isSecure: true, isHidden: true, isMandatory: true))
        
    init(_ auth: UserAuthViewModel, _ data: DBViewModel) {
        self.auth = auth
        self.data = data
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Text("register.createNewUser.title")
                    .font(.largeTitle)
                    .bold()
                TextFieldViewComponent(nameVM)
                TextFieldViewComponent(emailVM)
                TextFieldViewComponent(passwordVM)
                TextFieldViewComponent(repeatPasswordVM)
                HStack(spacing: 10) {
                    Button {
                        nameVM.validate()
                        emailVM.validate()
                        passwordVM.validate()
                        repeatPasswordVM.validate()
                    } label: {
                        Text("form.createUser.button")
                            .applyMLButtonStyle(height: 80)
                    }
                    Button {
                        nameVM.cleanField()
                        emailVM.cleanField()
                        passwordVM.cleanField()
                        repeatPasswordVM.cleanField()
                    } label: {
                        Text("form.clean.button")
                            .applyMLButtonStyle(.secondary, height: 80)
                    }
                }
            }
            .padding()
        }
        /*
         Task {
             await auth.signUp(with: formVM.credentials)
         }
         */
    }
}

#Preview {
    CreateNewUserView(.init(), .init())
}
