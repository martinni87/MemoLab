//
//  MLToolBarModifier.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 18/1/25.
//

import SwiftUI

struct MLToolBarModifier: ViewModifier {
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
    func setMLToolbarStyle() -> some View {
        return self.modifier(MLToolBarModifier())
    }
}
