//
//  SplashScreenView.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 4/4/25.
//


import SwiftUI

struct LaunchView: View {
    @StateObject private var viewModel = LaunchViewModel()
    @ObservedObject var auth: UserAuthViewModel
    
    var body: some View {
        ZStack {
            Group {
                if auth.userCanAccess {
                    MainView(auth: auth)
                        .opacity(auth.isWaitingResponse ? 0.5 : viewModel.opacity)
                        .onAppear {
                            viewModel.animateMainViewOpacity()
                        }
                        .onDisappear {
                            viewModel.opacity = 0
                        }
                } else {
                    PreLoginView(auth: auth)
                        .opacity(auth.isWaitingResponse ? 0.5 : 1)
                        .disabled(auth.isWaitingResponse)
                }
            }
            .blur(radius: auth.isWaitingResponse ? 2 : 0, opaque: false)
            if auth.isWaitingResponse {
                MLWaitingViewComponent()
            }
        }

    }
}

#Preview("SplashScreen") {
    LaunchView(auth: .init())
}
