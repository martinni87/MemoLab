//
//  LoginFormViewModel.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 30/3/25.
//

import Foundation

final class LoginFormViewModel: BaseAuthForm {
    
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
    
    func validate() {
        let emailIsValid = validateEmail()
        let passwordIsValid = validatePassword()
        isValid = emailIsValid && passwordIsValid
    }
    
    func cleanFields() {
        emailField.text = ""
        passwordField.text = ""
        isValid = false
    }
    
}
