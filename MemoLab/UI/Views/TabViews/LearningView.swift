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
                Text("learningView.notStarted.label")
                Image("IconStartStudyGuy")
                    .applyMLImageStyle(size: 150)
                    .background {
                        Circle()
                            .foregroundStyle(.accent.opacity(0.5))
                    }
                Text("learningView.notStarted.indications")
            }
            .multilineTextAlignment(.center)
            .bold()
            .padding()
    }
}

#Preview("Sin quotes") {
    LearningView(.init(), .init())
}
