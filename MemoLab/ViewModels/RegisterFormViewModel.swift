//
//  RegisterFormViewModel.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 30/3/25.
//

import Foundation

final class RegisterFormViewModel: ObservableObject {
    @Published var emailField = TextFieldModel(label: "form.email.label", hint: "form.email.hint")
    @Published var passwordField = TextFieldModel(label: "form.password.label")
    @Published var repeatPasswordField = TextFieldModel(label: "form.repeatPassword.label")
    @Published var verificationMail = TextFieldModel(label: "form.verificationMail.label", hint: "form.verificationMail.hint")
    @Published var isValid: Bool = false
    
    private func validateEmail() -> Bool {
        guard !emailField.text.isEmpty else {
            emailField.error = .fieldIsEmpty
            return false
        }
        let predicate = NSPredicate(format: "SELF MATCHES[c] %@", EMAIL_PATTERN)
        let formatIsValid = predicate.evaluate(with: emailField.text)
        
        guard formatIsValid else {
            emailField.error = .formatIsInvalid
            return false
        }
        emailField.error = nil
        return true
    }
    
    private func validatePassword() -> Bool {
        guard !passwordField.text.isEmpty else {
            passwordField.error = .fieldIsEmpty
            return false
        }
        passwordField.error = nil
        return true
    }
    
    private func validateRepeatPassword() -> Bool {
        guard !repeatPasswordField.text.isEmpty else {
            repeatPasswordField.error = .fieldIsEmpty
            return false
        }
        repeatPasswordField.error = nil
        return true
    }
    
    private func validatePasswordMatch() -> Bool {
        guard passwordField.text == repeatPasswordField.text else {
            passwordField.error = .passwordDoNotMatch
            repeatPasswordField.error = .passwordDoNotMatch
            return false
        }
        
        passwordField.error = nil
        repeatPasswordField.error = nil
        return true
    }
    
    func validate() {
        let emailIsValid = validateEmail()
        let passwordIsNotEmpty = validatePassword()
        let repeatPasswordIsNotEmpty = validateRepeatPassword()
        var passwordMatch = false

        if passwordIsNotEmpty && repeatPasswordIsNotEmpty {
            passwordMatch = validatePasswordMatch()
        }
        
        isValid = emailIsValid && passwordIsNotEmpty && repeatPasswordIsNotEmpty && passwordMatch
    }
    
    func cleanFields() {
        emailField.text = ""
        passwordField.text = ""
        repeatPasswordField.text = ""
        emailField.error = nil
        passwordField.error = nil
        repeatPasswordField.error = nil
    }
    
    func sendVerificationCode() {
        
    }
    
    func confirmVerificationCode() {
        
    }
    
}
