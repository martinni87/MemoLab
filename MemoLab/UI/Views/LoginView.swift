//
//  LoginView.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 16/2/25.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var auth: UserAuthViewModel
    @ObservedObject var data: DBViewModel
    
    @State var credentials: UserCredentials = .init(email: "", password: "")
    
    init(_ auth: UserAuthViewModel, _ data: DBViewModel) {
        self.auth = auth
        self.data = data
    }
    
    var body: some View {
        VStack(spacing: 50) {
            Text("Login").font(.largeTitle).fontWeight(.black)
            Button("Login Anónimo") {
                Task {
                    await auth.signInAnonymously()
                }
            }
            Text("O").bold().font(.title3)
            TextField("Email", text: $credentials.email)
            TextField("Password", text: $credentials.password)
            Button("Login with email and password") {
                Task {
                    await auth.signIn(with: credentials)
                }
            }
        }
        .padding()
        .alert("Error in login", isPresented: $auth.hasError) {
            Button("OK") {}
        } message: {
            Text(auth.error)
        }
        .fullScreenCover(isPresented: $auth.userLogged) {
            MainView(auth, data)
        }
    }
}

#Preview {
    LoginView(.init(), .init())
}
