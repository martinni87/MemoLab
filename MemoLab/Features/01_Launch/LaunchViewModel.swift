//
//  PreLoginViewModel.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 13/4/25.
//

import SwiftUI

final class LaunchViewModel: BaseViewModel {
    
    @Published var firstAppearance: Bool = true
    @Published var positionY: CGFloat = 0
    @Published var showButtons: Bool = false
    @Published var opacity: Double = 0.0
    
    func animateLogo(_ geometry: GeometryProxy) {
        if firstAppearance {
            positionY = geometry.size.height/2
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                withAnimation(.bouncy(duration: 2.0)) {
                    self.positionY = 150
                } completion: { [self] in
                    showButtons = true
                    firstAppearance = false
                }
            }
        }
    }
    
    func animateButtonsOpactiy() {
        DispatchQueue.main.asyncAfter(deadline: .now()) {
            withAnimation(.easeIn(duration: 0.75)) {
                self.opacity = 1
            }
        }
    }
    
    func animateMainViewOpacity() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation(.easeInOut(duration: 0.5)) {
                self.opacity = 1
            }
        }
    }
}
