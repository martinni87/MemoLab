//
//  SplashScreen.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 12/1/25.
//

import SwiftUI

struct SplashScreen: View {
    
    @ObservedObject var auth: UserAuthViewModel
    @ObservedObject var data: DBViewModel
    @State private var scale: CGFloat
    @State private var opacity: CGFloat
    @State private var showHomeScreen: Bool
    @State private var positionY: CGFloat
    
    init(_ auth: UserAuthViewModel, _ data: DBViewModel) {
        self.auth = auth
        self.data = data
        self.scale = 1.0
        self.opacity = 1.0
        self.showHomeScreen = false
        self.positionY = 0.0
    }
    
    var body: some View {
        ZStack {
            if showHomeScreen {
                if let _ = auth.userAuth {
                    MainView(auth, data)
                } else {
                    LoginView(auth, data)
                }
            } else {
                VStack {
                    Image("SplashScreen")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                    Text("app.title")
                        .font(.system(size: 36, weight: .black, design: .serif))
                }
                .scaleEffect(scale)
                .opacity(opacity)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        withAnimation(.easeInOut(duration: 1.5)) {
                            scale = 0
                            opacity = 0
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.5) {
                        withAnimation(.easeInOut(duration: 0.75)) {
                            showHomeScreen = true
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreen(.init(), .init())
}
