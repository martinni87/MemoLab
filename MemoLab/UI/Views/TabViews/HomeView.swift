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
                Text("home.welcome.title")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 30)
                HomeHeaderSubView(data: data)
                    .padding(40)
                ListOfBooksView(data: data)
                HomeFooterSubView()
                    .padding(40)
            }
            .alert("alert.bookNotAvailable.title", isPresented: $data.hasError) {
                Button("alert.primary.button"){}
            } message: {
                Text("alert.bookNotAvailable.message")
            }
        }
    }
}


#Preview {
    NavigationStack {
        HomeView(.init(), .init())
    }
}
