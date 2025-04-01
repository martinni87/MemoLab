//
//  MLError.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 18/1/25.
//

import Foundation

enum MLError: String, Error {
    case invalidURL = "There is a problem with the Database URL"
    case invalidResponse = "There was a problema processing the data and response from server"
    case invalidCollection = "The collection your looking for is not in the database or the path is wrong"
    case invalidDataDecoding = "Something went wrong decoding your data. Check the code"
    case invalidDataEncoding = "Something went wrong encoding your data. Check the code"
    case invalidSignUp = "Invalid sign up"
    case invalidSignIn = "Invalid sign in"
    case invalidSignOut = "Invalid sign out"
    case invalidTokenGet = "Invalid token get"
    case sanpshotIsNil = "DB Snapshot is nil"
    case unknown = "Unknown error"
}

enum MLFormError: String, Error {
    case fieldIsEmpty = "form.error.isEmpty"
    case formatIsInvalid = "form.error.formatInvalid"
    case passwordDoNotMatch = "form.error.passwordDoNotMatch"
    
    var localized: String {
        self.rawValue.localized
    }
}
