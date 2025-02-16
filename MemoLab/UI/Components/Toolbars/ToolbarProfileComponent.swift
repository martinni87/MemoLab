//
//  ToolbarProfileComponent.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 18/1/25.
//

import SwiftUI

struct ToolbarProfileComponent: View {
    
    @Binding var showProfile: Bool
    
    var body: some View {
        Image(systemName: "person.fill")
            .resizable()
            .frame(width: 20, height: 20)
            .padding(10)
            .foregroundStyle(.black)
            .clipShape(.circle)
            .background {
                Circle()
                    .fill(.accent)
            }
            .padding(.bottom, 20)
            .onTapGesture {
                showProfile.toggle()
            }
    }
}

#Preview {
    ToolbarProfileComponent(showProfile: .constant(false))
}
