//
//  PreLoginViewModel.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 14/4/25.
//

import Foundation

final class PreLoginViewModel: ObservableObject {
    @Published var accessAnonymously = false
    @Published var goToLoginView = false
    @Published var goToRegisterView = false
}
