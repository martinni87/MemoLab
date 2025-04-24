//
//  QuoteNotesComponent.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 21/4/25.
//

import SwiftUI

struct QuoteNotesComponent: View {
    
    @State var text: String = ""
    @State var height: CGFloat = 0
    @State var opacity: CGFloat = 0
    @State var showNotes: Bool = false
    
    var body: some View {
        VStack(spacing: 10){
            Button {
                showNotes.toggle()
            } label: {
                if showNotes {
                    Label("activity.hideNotes.button", systemImage: "chevron.up")
                        .applyMLButtonStyle(.link)
                } else {
                    Label("activity.showNotes.button", systemImage: "chevron.down")
                        .applyMLButtonStyle(.link)
                }
            }
            TextEditor(text: $text)
                .textEditorStyle(.plain)
                .padding()
                .background(Color.colorPaper)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(radius: 5)
                .frame(height: height)
                .opacity(opacity)
                .onChange(of: showNotes) { _,_ in
                    if showNotes {
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            withAnimation(.linear(duration: 0.15)) {
                                height = 350
                                opacity = 1
                            }
                        }
                    } else {
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            withAnimation(.linear(duration: 0.15)) {
                                height = 0
                                opacity = 0
                            }
                        }
                    }
                }
        }
    }
}

#Preview {
    QuoteNotesComponent()
}
