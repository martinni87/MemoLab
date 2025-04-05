//
//  MLWaitingViewComponent.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 5/4/25.
//

import SwiftUI

struct MLWaitingViewComponent: View {
    
    @Binding var isLoading: Bool
    @State private var degrees: Double = 0.0
    @State private var animationTimer: Timer?
    
    var body: some View {
        Circle()
//            .trim(from: 0.0, to: 0.8)
            .stroke(Gradient(colors: [.red.opacity(0.8),.purple, .blue]), lineWidth: 10)
            .frame(height: 50)
            .rotationEffect(.degrees(degrees))
            .onAppear {
                startSpinning()
            }
            .onDisappear {
                stopSpinning()
            }
    }
    
    private func startSpinning() {
            stopSpinning() // prevent duplicate timers
            animationTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                degrees += 8
            }
        }
        
        private func stopSpinning() {
            animationTimer?.invalidate()
            animationTimer = nil
            degrees = 0
        }
}

#Preview {
    MLWaitingViewComponent(isLoading: .constant(true))
}
