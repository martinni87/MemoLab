//
//  MLFixedFrameSize.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 14/4/25.
//

import SwiftUI

struct MLFixedFrameSize: ViewModifier {
    
    let width: CGFloat
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    func body(content: Content) -> some View {
        content
            .frame(width: horizontalSizeClass == .compact ? .infinity : width)
    }
}

extension View {
    func applyFixedFrameSize(width: CGFloat = 450) -> some View {
        return self.modifier(MLFixedFrameSize(width: width))
    }
}
