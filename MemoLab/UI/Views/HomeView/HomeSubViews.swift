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
        VStack {
            if let quote = data.onboardingQuote?.text {
                VStack(alignment: .center, spacing: 40){
                    Text(quote)
                    if let author = data.onboardingQuote?.author {
                        Text(author)
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
        .onAppear{
            Task {
                await data.fetchRandomOnboardingQuote()
            }
        }
    }
}

struct HomeFooterSubView: View {
    var body: some View {
        HStack(alignment: .center, spacing: 20) {
            Image(systemName: "info.circle")
                .scaleEffect(2)
            Text("footer.info.message")
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
