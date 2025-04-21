//
//  MLTextStyleModifier.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 15/2/25.
//

import SwiftUI

enum TextStyle {
    case title, title2, title3, body
}

struct MLTextStyleModifier: ViewModifier {
    
    private let alignment: TextAlignment
    private let lineSpacing: CGFloat
    private let fontStyle: Font
    
    init(_ style: TextStyle, _ alignment: TextAlignment) {
        self.alignment = alignment
        
        switch style {
        case .title:
            self.lineSpacing = 5
            self.fontStyle = .system(size: 36, weight: .black, design: .serif)
        case .title2:
            self.lineSpacing = 5
            self.fontStyle = .system(size: 30, weight: .bold, design: .serif)
        case .title3:
            self.lineSpacing = 5
            self.fontStyle = .system(size: 24, weight: .semibold, design: .serif)
        case .body:
            self.lineSpacing = 18
            self.fontStyle = .system(size: lineSpacing, weight: .light, design: .serif)
        }
    }
    
    func body(content: Content) -> some View {
        HStack {
            if alignment == .trailing {
                Spacer()
            }
            content
                .font(fontStyle)
                .lineSpacing(lineSpacing)
                .multilineTextAlignment(alignment)
            if alignment == .leading {
                Spacer()
            }
        }
    }
}

extension View {
    func setMLTextStyle(_ style: TextStyle = .body, alignment: TextAlignment = .leading) -> some View {
        return self.modifier(MLTextStyleModifier(style, alignment))
    }
}
