//
//  PreLoginView.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 30/3/25.
//

import SwiftUI

struct PreLoginView: View {
    
    @ObservedObject var auth: UserAuthViewModel
    @StateObject private var viewModel = LaunchViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ZStack {
                    SplashLogoComponent()
                        .position(x: geometry.size.width/2,
                                  y: viewModel.positionY)
                        .onAppear {
                            viewModel.animateLogo(geometry)
                        }
                    if viewModel.showButtons {
                        PreLoginButtonsComponent(auth: auth)
                            .padding(.top, 150)
                            .applyFixedFrameSize()
                            .opacity(viewModel.opacity)
                            .onAppear {
                                viewModel.animateButtonsOpactiy()
                            }
                    }
                }
            }
        }
    }
}

#Preview {
    PreLoginView(auth: .init())
}


