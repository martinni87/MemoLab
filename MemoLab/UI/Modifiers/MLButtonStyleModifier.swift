//
//  MLButtonStyleModifier.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 23/2/25.
//

import SwiftUI

enum MLButtonStyle {
    case primary, secondary, link
}

struct MLButtonStyleModifier: ViewModifier {
    
    let style: MLButtonStyle
    let width :CGFloat
    let height: CGFloat
    
    func body(content: Content) -> some View {
        content
            .buttonStyle(.plain)
            .font(.headline)
            .padding()
            .frame(maxWidth: width)
            .frame(height: height)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .multilineTextAlignment(.center)
            .cornerRadius(8)
    }

    private var backgroundColor: Color {
        switch style {
        case .primary: return Color("ColorButtonPrimary")
        case .secondary: return Color("ColorButtonSecondary")
        case .link: return Color(uiColor: .systemBackground)
        }
    }

    private var foregroundColor: Color {
        switch style {
        case .primary: return Color.white
        case .secondary: return Color.white
        case .link: return Color(uiColor: .systemBlue)
        }
    }
}

extension View {
    func applyMLButtonStyle(_ style: MLButtonStyle = .primary, width: CGFloat = .infinity, height: CGFloat = 50) -> some View {
        return self.modifier(MLButtonStyleModifier(style: style, width: width, height: height))
    }
}
