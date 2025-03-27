//
//  ToolbarTitleComponent.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 18/1/25.
//

import SwiftUI

struct ToolbarTitleComponent: View {
    
    @Binding var selection: Int
    
    var body: some View {
        HStack {
            Spacer()
            HStack(spacing: 10){
                Image(systemName: "book.fill")
                    .resizable().scaledToFit().frame(height: 30)
                VStack(alignment: .center){
                    Text("app.title").font(.title3)
                    Text(selection == 0 ? "toolbar.myQuotes.title" : selection == 1 ? "toolbar.home.title" : "toolbar.profile.title")
                }
            }
            .foregroundStyle(.white)
            .labelStyle(.titleAndIcon)
            .fontWeight(.black)
            .fontDesign(.serif)
            .onTapGesture {
                selection = 0
            }
            Spacer()
        }
        .padding(.bottom, 5)
        .scaleEffect(0.8)
    }
}

#Preview {
    ToolbarTitleComponent(selection: .constant(1))
        .background(.colorToolbarBackground)
}
