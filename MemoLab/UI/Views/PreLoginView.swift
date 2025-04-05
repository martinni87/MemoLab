//
//  PreLoginView.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 30/3/25.
//

import SwiftUI

struct PreLoginView: View {
    
    @ObservedObject var auth: UserAuthViewModel
    @ObservedObject var data: DBViewModel
    @State private var firstAppearance: Bool = true
    @State private var showButtons: Bool = false
    @State private var positionY: CGFloat = 0.0
    @State private var opacity: Double = 0.0
    
    init(_ auth: UserAuthViewModel, _ data: DBViewModel) {
        self.auth = auth
        self.data = data
    }
    
    var body: some View {
        if auth.userCanAccess {
            MainView(auth, data)
        } else {
            GeometryReader { geometry in
                NavigationStack {
                    ZStack {
                        VStack {
                            Image("SplashScreen")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 200, height: 200)
                                .clipShape(Circle())
                            Text("app.title")
                                .font(.system(size: 36, weight: .black, design: .serif))
                        }
                        .position(x: geometry.size.width/2, y: positionY)
                        .onAppear {
                            if firstAppearance {
                                positionY = geometry.size.height/2
                                DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                                    withAnimation(.bouncy(duration: 2.0)) {
                                        positionY = 150
                                    } completion: {
                                        showButtons = true
                                        firstAppearance = false
                                    }
                                }
                            }
                        }
                        if showButtons {
                            PreLoginButtonsSetComponent(auth, data)
                                .padding(.top, 150)
                                .opacity(opacity)
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                                        withAnimation(.easeIn(duration: 0.75)) {
                                            opacity = 1
                                        }
                                    }
                                }
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    PreLoginView(.init(), .init())
}

struct PreLoginButtonComponent: View {
    
    private let imageResource: String
    private let localizedTextKey: String
    
    init(image: String, text: String) {
        self.imageResource = image
        self.localizedTextKey = text
    }
    
    var body: some View {
        HStack {
            Image(systemName: imageResource)
            Spacer()
            Text(localizedTextKey.localized)
            Spacer()
        }
        .applyMLButtonStyle(.prelogin)
    }
}

struct PreLoginButtonsSetComponent: View {
    
    @ObservedObject var auth: UserAuthViewModel
    @ObservedObject var data: DBViewModel
    @State private var anonymousLogin = false
    
    init(_ auth: UserAuthViewModel, _ data: DBViewModel) {
        self.auth = auth
        self.data = data
    }
    
    var body: some View {
        VStack {
            Button {
                anonymousLogin.toggle()
            } label: {
                PreLoginButtonComponent(
                    image: "person.fill.questionmark",
                    text: "prelogin.accessAnonymously.button")
            }
            NavigationLink {
                LoginView(auth,data)
            } label: {
                PreLoginButtonComponent(
                    image: "envelope.fill",
                    text: "prelogin.accessWithEmail.button")
            }
            NavigationLink {
                RegisterView(auth, data)
            } label: {
                PreLoginButtonComponent(
                    image: "person.fill.badge.plus",
                    text: "prelogin.createUser.button")
            }
        }
        .padding()
        .alert("alert.anonymous.title", isPresented: $anonymousLogin) {
            Button("alert.anonymous.primary.button") {
                Task {
                    await auth.signInAnonymously()
                }
            }
            Button("alert.anonymous.cancel.button") {
                anonymousLogin = false
            }
        } message: {
            Text("alert.anonymous.warning.message")
        }
    }
}


