//
//  UserModels.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 16/2/25.
//

import Foundation

struct UserAuthModel: Identifiable {
    let id: String
    let isAnonymous: Bool
    let name: String
}

struct UserCredentials {
    var email: String
    var password: String
}
