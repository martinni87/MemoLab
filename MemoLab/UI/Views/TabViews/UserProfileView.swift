//
//  UserProfileView.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 16/2/25.
//

import SwiftUI
    
struct UserProfileView: View {
    
    @ObservedObject var auth: UserAuthViewModel
    @ObservedObject var data: DBViewModel
    
    init(_ auth: UserAuthViewModel, _ data: DBViewModel) {
        self.auth = auth
        self.data = data
    }
    
    var body: some View {
        VStack {
            Text("Hello \(auth.userAuth?.name ?? "Anónimo")")
            Button("Logout") {
                auth.signOut()
            }
        }
    }
}

#Preview {
    UserProfileView(UserAuthViewModel(), DBViewModel())
}
