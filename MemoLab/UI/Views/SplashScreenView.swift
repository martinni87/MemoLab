//
//  SplashScreenView.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 4/4/25.
//


import SwiftUI

struct SplashScreenView: View {
    
    @ObservedObject var auth: UserAuthViewModel
    @ObservedObject var data: DBViewModel
    
    init(_ auth: UserAuthViewModel, _ data: DBViewModel) {
        self.auth = auth
        self.data = data
    }
    
    var body: some View {
        if auth.userCanAccess {
            MainView(auth, data)
        } else {
            PreLoginView(auth, data)
        }
    }
}
