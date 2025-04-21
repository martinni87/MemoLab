//
//  QuoteNotesComponent.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 21/4/25.
//

import SwiftUI

struct QuoteNotesComponent: View {
    
    @State var text: String = ""
    
    var body: some View {
        TextEditor(text: $text)
            .textEditorStyle(.plain)
            .padding()
            .background(Color.colorPaper)
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .shadow(radius: 5)
            .padding()
            .lineSpacing(1.5)
            .multilineTextAlignment(.leading)
            .font(.system(size: 16, weight: .medium, design: .rounded))
            .italic()
    }
}

#Preview {
    QuoteNotesComponent()
}
