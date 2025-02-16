//
//  HomeSubViews.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 18/1/25.
//

import SwiftUI

struct HomeHeaderSubView: View {
    
    @ObservedObject var data: DBViewModel

    var body: some View {
        VStack(alignment: .center, spacing: 40){
                if let quote = data.onboardingQuote?.text {
                    Text(quote)
                } else {
                    Text("A todo corazón que memorice Sus Palabras, si es el de un creyente, Dios hará que se llene con Su amor.")
                }
                if let author = data.onboardingQuote?.author {
                    Text(author)
                } else {
                    Text("- Extracto de los escritos bahá'ís -")
                }
        }
        .onAppear{
            Task {
                await data.fetchRandomOnboardingQuote()
            }
        }
        .multilineTextAlignment(.center)
        .padding(20)
        .background{
            Rectangle()
                .fill(.colorPaper)
                .shadow(radius: 10)
        }
        .lineSpacing(20)
    }
}

struct HomeFooterSubView: View {
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Image(systemName: "info.circle")
                .scaleEffect(2)
            Text("Próximamente habrán más memorizaciones del libro de oraciones. No te pierdas las actualizaciones ♥︎")
        }
        .padding(.vertical)
        .foregroundStyle(Color(uiColor: .systemBlue))
        .multilineTextAlignment(.center)
        .font(.caption)
    }
}

#Preview("Header") {
    HomeHeaderSubView(data: DBViewModel())
}

#Preview("Footer") {
    HomeFooterSubView()
}
