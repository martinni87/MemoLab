//
//  MLTextComponent.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 25/1/25.
//

import SwiftUI

struct MLTextComponent: View {
    
    enum TextStyle {
        case title, title2, title3, body
    }
    
    let text: String
    let alignment: TextAlignment
    private let style: TextStyle
    private let lineSpacing: CGFloat
    private let fontStyle: Font
    
    init(_ text: String, alignment: TextAlignment = .leading, style: TextStyle = .body) {
        self.text = text
        self.alignment = alignment
        self.style = style
        
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
    
    var body: some View {
        HStack {
            if alignment == .trailing {
                Spacer()
            }
            Text(text)
                .font(fontStyle)
                .lineSpacing(lineSpacing)
                .multilineTextAlignment(alignment)
            if alignment == .leading {
                Spacer()
            }
        }
    }
    
    
}

#Preview {
    VStack(spacing: 30){
        MLTextComponent("Libro",alignment: .leading, style: .title)
        MLTextComponent("Unidad",alignment: .center, style: .title2)
        MLTextComponent("Sección",alignment: .leading, style: .title3)
        MLTextComponent("Cuerpo del texto donde se va a escribir una cita",alignment: .trailing, style: .body)
    }
    .padding(.horizontal, 40)
}
