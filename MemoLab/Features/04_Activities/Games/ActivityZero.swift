//
//  ActivityZero.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 22/4/25.
//

import SwiftUI

struct ActivityZero: View {
    
    var activity: ActivityModel
    let text: String = "This is an example of a text"
    
    var body: some View {
        VStack {
            QuoteComponent(quote: activity.quote)
            QuoteNotesComponent(text: text)
        }
    }
}

#Preview {
    ActivityZero(activity: .init(quote: Quote.sample))
}
