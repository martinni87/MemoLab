//
//  MLButtonStyleModifier.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 23/2/25.
//

import SwiftUI

enum MLButtonStyle {
    case primary, secondary, prelogin, link
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
            .overlay {
                if style == .prelogin {
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color("ColorButtonPreloginStroke"), lineWidth: 2)
                }
            }
    }

    private var backgroundColor: Color {
        switch style {
        case .primary: return Color("ColorButtonPrimary")
        case .secondary: return Color("ColorButtonSecondary")
        case .prelogin: return Color("ColorButtonPrelogin")
        case .link: return Color(uiColor: .systemBackground)
        }
    }

    private var foregroundColor: Color {
        switch style {
        case .primary, .secondary: return Color.white
        case .prelogin: return Color("ColorButtonTextPrelogin")
        case .link: return Color(uiColor: .systemBlue)
        }
    }
}

extension View {
    func applyMLButtonStyle(_ style: MLButtonStyle = .primary, width: CGFloat = .infinity, height: CGFloat = 50) -> some View {
        return self.modifier(MLButtonStyleModifier(style: style, width: width, height: height))
    }
}
