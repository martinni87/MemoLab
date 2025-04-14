//
//  AuthFormProtocol.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 5/4/25.
//

import Foundation

class BaseAuthForm: BaseViewModel {
    @Published var emailField = TextFieldModel(label: "form.email.label", hint: "form.email.hint")
    @Published var passwordField = TextFieldModel(label: "form.password.label")
    @Published var isValid: Bool = false
}
