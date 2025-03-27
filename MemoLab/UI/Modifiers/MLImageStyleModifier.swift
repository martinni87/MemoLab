//
//  MLImageStyleModifier.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 27/3/25.
//

import SwiftUI

struct MLImageStyleModifier: ViewModifier {
    
    let image: Image
    let size: CGFloat
    
    func body(content: Content) -> some View {
        image
            .resizable()
            .scaledToFit()
            .frame(width: size)
    }
}

extension Image {
    func applyMLImageStyle(size: CGFloat = 100) -> some View {
        return self.modifier(MLImageStyleModifier(image: self, size: size))
    }
}
