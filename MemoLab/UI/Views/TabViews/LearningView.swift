//
//  MemorizationsView.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 6/2/25.
//

import SwiftUI

struct LearningView: View {
    
    @ObservedObject var auth: UserAuthViewModel
    @ObservedObject var data: DBViewModel
    
    init(_ auth: UserAuthViewModel, _ data: DBViewModel) {
        self.auth = auth
        self.data = data
    }
    
    var body: some View {
            VStack(spacing: 40) {
                Text("¿Aun no has empezado a memorizar?")
                Text("📖")
                    .scaleEffect(2)
                Text("Vuelve a la pantalla de inicio para seleccionar un libro y estudiar alguna cita.")
                    .font(.title3)
            }
            .multilineTextAlignment(.center)
            .font(.title)
            .bold()
            .padding()
    }
}

#Preview("Sin quotes") {
    LearningView(.init(), .init())
}
