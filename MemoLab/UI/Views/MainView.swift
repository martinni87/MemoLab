//
//  MainView.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 25/1/25.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var auth: UserAuthViewModel
    @ObservedObject var data: DBViewModel
    @State var selection: Int
    
    init(_ auth: UserAuthViewModel, _ data: DBViewModel) {
        self.auth = auth
        self.data = data
        selection = 1
    }
    
    var body: some View {
        NavigationStack {
            TabView(selection: $selection) {
                Tab("toolbar.myQuotes.title", systemImage: "book.fill", value: 0) {
                    LearningView(auth, data)
                }
                Tab("toolbar.home.title", systemImage: "house.fill", value: 1) {
                    HomeView(auth, data)
                }
                Tab("toolbar.profile.title", systemImage: "person.circle.fill", value: 2) {
                    UserProfileView(auth, data)
                }
            }
            .navigationTitle(
                selection == 0 ? "toolbar.myQuotes.title" : selection == 1 ? "toolbar.home.title" : "toolbar.profile.title"
            )
            .toolbarTitleDisplayMode(.inline)
            .toolbarBackground(Color.colorToolbarBackground, for: .navigationBar)
            .toolbarBackgroundVisibility(.visible, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    ToolbarTitleComponent(selection: $selection)
                }
            }
        }
    }
}


#Preview {
    MainView(UserAuthViewModel(), DBViewModel())
}
