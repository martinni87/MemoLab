//
//  MLNavigationLink.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 25/1/25.
//

import SwiftUI

struct MLNavigationLink: View {

    let text: String
    let destination: AnyView

    init(_ text: String, destination: AnyView) {
        self.text = text
        self.destination = destination
    }
    var body: some View {
        NavigationLink {
            destination
        } label: {
            Text(text)
                .font(.headline)
                .padding()
                .frame(maxWidth: .infinity)
                .background(.clear)
                .foregroundColor(Color(uiColor: .systemBlue))
                .cornerRadius(8)
                .background { navigationBorder }
        }
    }
    
    private var navigationBorder: some View {
        ZStack(alignment: .trailing) {
            Rectangle()
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .foregroundStyle(Color(uiColor: .systemBackground))
                .shadow(color: Color(uiColor: .systemBlue), radius: 1.5, x: 0, y: 0)
            Image(systemName: "chevron.right")
                .foregroundStyle(Color(uiColor: .systemBlue))
                .padding()
        }
            
    }
}

#Preview {
    NavigationStack {
        MLNavigationLink("Navigation text",
                         destination: (AnyView(Text("View destination"))))
            .padding(20)
    }
}
