//
//  DismissViewComponent.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 12/1/25.
//

import SwiftUI

struct MLDismissViewComponent: View {
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Button {
            dismiss()
        } label: {
            Image(systemName: "xmark.circle.fill")
                .foregroundStyle(.colorButtonPrimary)
        }
    }
}

#Preview {
    MLDismissViewComponent()
}
