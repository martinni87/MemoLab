//
//  ActivityOne.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 22/4/25.
//

import SwiftUI

struct ActivityOne: View {
    
    @ObservedObject var activityVM: ActivityViewModel
    
    var body: some View {
        if let orderedWords = activityVM.orderedWords {
            HStack {
                ForEach(orderedWords) { part in
                    if part.startsHidden {
                        Text("_____")
                    } else if(part.isSelected){
                        Text(part.word)
                            .foregroundStyle(.blue)
                    }else {
                        Text(part.word)
                    }
                }
            }
        }
        if let hiddenWords = activityVM.hiddenWords {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100, maximum: 200))]) {
                ForEach(hiddenWords) { part in
                    Button(part.word) {
                        
                    }
                }
            }
        }
    }
}

#Preview {
    @Previewable @StateObject var activityVM = ActivityViewModel(activity: ActivityModel(quote: Quote.sample, order: 3))
    ActivityOne(activityVM: activityVM)
}
