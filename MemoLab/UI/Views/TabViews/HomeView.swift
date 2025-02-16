//
//  HomeView.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 18/1/25.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var auth: UserAuthViewModel
    @ObservedObject var data: DBViewModel

    init(_ auth: UserAuthViewModel, _ data: DBViewModel) {
        self.auth = auth
        self.data = data
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                Text("Bienvenido/a")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 30)
                HomeHeaderSubView(data: data)
                    .padding(40)
                ListOfBooksView(data: data)
                HomeFooterSubView()
                    .padding(40)
            }
            .alert("Libro no disponible por el momento", isPresented: $data.hasError) {
                Button("OK"){}
            } message: {
                Text("Las actividades de este libro estarán disponibles próximamente\n¡Gracias por tu paciencia! ♥︎")
            }
        }
    }
}


#Preview {
    NavigationStack {
        HomeView(.init(), .init())
    }
}
