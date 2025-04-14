//
//  QuoteComponent.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 6/4/25.
//

import SwiftUI

struct QuoteComponent: View {
    
    let quote: Quote
    
    var body: some View {
        VStack {
            SeparatorComponent()
            Text(quote.text)
                .padding()
                .fontDesign(.serif)
                .fontWeight(.semibold)
                .italic()
                .lineSpacing(2)
            if let author = quote.author {
                Text(author)
                    .fontDesign(.serif)
                    .fontWeight(.semibold)
                    .italic()
                    .lineSpacing(2)
            }
            SeparatorComponent()
        }
        .background {
            RoundedRectangle(cornerRadius: 15)
                .fill(.teal.opacity(0.25))
                .padding(.vertical)
        }
        .applyFixedFrameSize()

    }
    
}

#Preview {
    QuoteComponent(quote: .sample)
}
