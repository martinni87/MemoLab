//
//  MLButtonStyleModifier.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 23/2/25.
//

import SwiftUI

struct MLButtonStyleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .toolbarBackgroundVisibility(.visible, for: .automatic)
            .toolbarBackground(.accent, for: .automatic)
            .toolbarBackgroundVisibility(.visible, for: .bottomBar)
            .toolbarBackground(.accent, for: .bottomBar)
            .toolbarTitleDisplayMode(.inline)
    }
}

extension View {
    func setMLButtonStyle() -> some View {
        return self.modifier(MLButtonStyleModifier())
    }
}
