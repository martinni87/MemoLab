//
//  LogoViewComponent.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 13/4/25.
//

import SwiftUI

struct SplashLogoComponent: View {
    var body: some View {
        VStack {
            Image("SplashScreen")
                .resizable()
                .scaledToFit()
                .frame(width: 200, height: 200)
                .clipShape(Circle())
            Text("app.title")
                .font(.system(size: 36, weight: .black, design: .serif))
        }
    }
}

#Preview {
    SplashLogoComponent()
}
