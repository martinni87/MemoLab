//
//  SeparatorComponent.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 6/4/25.
//

import SwiftUI

struct SeparatorComponent: View {
    var body: some View {
        Image("SeparatorLeaves")
            .resizable()
            .scaledToFit()
            .colorMultiply(.accent.opacity(0.75))
    }
}

#Preview {
    SeparatorComponent()
}
