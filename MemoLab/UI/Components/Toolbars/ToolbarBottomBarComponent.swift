//
//  ToolbarBottomBarComponent.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 26/1/25.
//

import SwiftUI

struct ToolbarBottomBarComponent: View {
    
    @Binding var selection: Int
        
    var body: some View {
        HStack(spacing: 50) {
            Button {
                selection = 0
            } label: {
                Image(systemName: "house")
            }
            .tint(selection != 0 ? .gray.opacity(0.5) : .accent)
            Button {
                selection = 1
            } label: {
                Image(systemName: "book")
            }
            .tint(selection != 1 ? .gray.opacity(0.5) : .accent)
        }
    }
}

#Preview {
    ToolbarBottomBarComponent(selection: .constant(0))
}
