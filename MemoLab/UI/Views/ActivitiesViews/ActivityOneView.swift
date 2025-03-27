//
//  ActivityOneView.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 2/2/25.
//

import SwiftUI
import SwiftData

struct ActivityZeroView: View {
    
    let quote: Quote
    private var activity: ActivityModel {
        .init(activity: .activityZero, quote: quote)
    }
//    @Query var user: UserDataModel
    @Environment(\.modelContext) private var modelContext
//    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20)  {
                Text("activity.zero.title").font(.largeTitle).bold()
                Text("activity.zero.description")
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

struct ActivityOneView: View {
    
    @ObservedObject var data: DBViewModel
    let quote: Quote
    
//    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20)  {
                Text("activity.one.title").font(.largeTitle).bold()
                Text("activity.one.description")
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
    
//    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("activity.two.title").font(.largeTitle).bold()
                Text("activity.two.description")
                Text(quote.text)
//                Button("") {
//                    dismiss()
//                }
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
    
//    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("activity.three.title").font(.largeTitle).bold()
                Text("activity.three.description")
                Text(quote.text)
//                Button("") {
//                    dismiss()
//                }
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
