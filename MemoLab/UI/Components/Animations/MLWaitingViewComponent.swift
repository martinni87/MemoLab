//
//  MLWaitingViewComponent.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 5/4/25.
//

import SwiftUI

struct MLWaitingViewComponent: View {
    
    @State private var degrees: Double = 0.0
    @State private var animationTimer: Timer?
    
    var body: some View {
            VStack(spacing: 30) {
                Circle()
                    .stroke(Gradient(colors: [.indigo,.accent])/*.opacity(0.75)*/, lineWidth: 10)
                    .frame(height: 20)
                    .rotationEffect(.degrees(degrees))
                    .onAppear {
                        startSpinning()
                    }
                    .onDisappear {
                        stopSpinning()
                    }
                Text("spinner.waiting.label")
                    .foregroundStyle(.white)
                    .font(.callout)
                    .bold()
            }
    }
    
    private func startSpinning() {
            stopSpinning()
            animationTimer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                degrees += 5
            }
        }
        
        private func stopSpinning() {
            animationTimer?.invalidate()
            animationTimer = nil
            degrees = 0
        }
}

#Preview {
    MLWaitingViewComponent()
}
