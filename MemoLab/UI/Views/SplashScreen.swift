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
//    @State private var opacity: Double = 1.0
    @State private var showHomeScreen: Bool
    @State private var positionY: CGFloat
    
    init(_ auth: UserAuthViewModel, _ data: DBViewModel) {
        self.auth = auth
        self.data = data
        self.scale = 1.0
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
                    Text("Memo Lab")
                        .font(.system(size: 36, weight: .black, design: .serif))
                }
                .scaleEffect(scale)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        withAnimation(.easeInOut(duration: 0.7)) {
                            scale = 100
                        }
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                        withAnimation(.easeInOut(duration: 0.5)) {
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
