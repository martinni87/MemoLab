//
//  ActivityOneView.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 2/2/25.
//

import SwiftUI

struct ActivityOneView: View {
    
    @ObservedObject var data: DBViewModel
    let quote: Quote
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20)  {
                Text("Activity One").font(.largeTitle).bold()
                Text("activity0_description")
                Text(quote.text)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    MLDismissViewComponent()
                }
            }
        }
    }
}

struct ActivityTwoView: View {
    
    @ObservedObject var data: DBViewModel
    let quote: Quote
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Activity Two").font(.largeTitle).bold()
                Text(quote.text)
                Button("Exit") {
                    dismiss()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    MLDismissViewComponent()
                }
            }
        }
    }
}

struct ActivityThreeView: View {
    
    @ObservedObject var data: DBViewModel
    let quote: Quote
    
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("Activity Three").font(.largeTitle).bold()
                Text(quote.text)
                Button("Exit") {
                    dismiss()
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    MLDismissViewComponent()
                }
            }
        }
    }
}

#Preview {
    ActivityOneView(data: DBViewModel(), quote: .sample)
}
