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
    @State var opacity: CGFloat = 0.0
    
    init(_ auth: UserAuthViewModel, _ data: DBViewModel) {
        self.auth = auth
        self.data = data
    }
    
    var body: some View {
        ZStack {
            Group {
                if auth.userCanAccess {
                    MainView(auth, data)
                        .opacity(auth.isWaitingResponse ? 0.5 : opacity)
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                withAnimation(.easeInOut(duration: 0.5)) {
                                    opacity = 1
                                }
                            }
                        }
                        .onDisappear {
                            opacity = 0
                        }
                } else {
                    PreLoginView(auth, data)
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
    SplashScreenView(.init(), .init())
}
