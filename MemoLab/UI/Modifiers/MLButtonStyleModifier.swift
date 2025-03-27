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
    
    init(_ style: MLButtonStyle) {
        self.style = style
    }
    
    func body(content: Content) -> some View {
        content
            .buttonStyle(.plain)
            .font(.headline)
            .padding()
            .frame(maxWidth: .infinity)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
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
    func applyMLButtonStyle(_ style: MLButtonStyle = .primary) -> some View {
        return self.modifier(MLButtonStyleModifier(style))
    }
}
