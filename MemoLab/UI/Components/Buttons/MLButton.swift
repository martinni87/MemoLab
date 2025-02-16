//
//  MLButton.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 25/1/25.
//

import SwiftUI

struct MLButton: View {
    
    enum ButtonStyle {
        case primary, secondary, link
    }

    let text: String
    let style: ButtonStyle
    let action: () async -> Void
    let isAsync: Bool
    
    init(_ text: String, style: ButtonStyle = .primary, isAsync: Bool = false, action: @escaping () async -> Void) {
        self.text = text
        self.style = style
        self.isAsync = isAsync
        self.action = action
    }
    
    var body: some View {
        Button {
            if isAsync {
                Task {
                    await action()
                }
            } else {
                Task.detached {
                    await action()
                }
            }
        } label: {
            Text(text)
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(backgroundColor)
                .foregroundColor(foregroundColor)
                .cornerRadius(8)
                .overlay(
                    style == .link ? underline : nil
                )
        }
        .buttonStyle(.plain)
    }

    private var backgroundColor: Color {
        switch style {
        case .primary: return Color("ColorButtonPrimary")
        case .secondary: return Color("ColorButtonSecondary")
        case .link: return Color(uiColor: .systemBackground)
        }
    }

    private var foregroundColor: Color {
        switch style {
        case .primary: return Color.white
        case .secondary: return Color.white
        case .link: return Color(uiColor: .systemBlue)
        }
    }

    private var underline: some View {
        Rectangle()
            .frame(height: 1)
            .foregroundColor(Color(uiColor: .systemBlue))
            .offset(y: 12)
    }
}

#Preview {
    @Previewable @StateObject var data = DBViewModel()
    
    VStack {
        MLButton("Primary Sync Button") {
            print("I'm a primary sync button")
        }
        MLButton("Secondary Sync Button", style: .secondary, isAsync: false) {
            print(data.ruhiBooksCollection.values.first?.title ?? "Nothing fetch yet")
        }
        MLButton("I'm just an async link", style: .link, isAsync: true) {
            await data.fetchRuhiBook(with: "Book1")
        }
    }
    .padding(.horizontal, 20)
}
