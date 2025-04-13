//
//  ActivityZeroView.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 2/2/25.
//

// MARK: Comentario para ubicar punto de retorno

import SwiftUI
import SwiftData

struct ActivityView: View {
    
    @ObservedObject private var activityVM: ActivityViewModel
    @ObservedObject private var data: DBViewModel
    
    init(_ activity: ActivityViewModel, _ data: DBViewModel) {
        self.activityVM = activity
        self.data = data
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                if let activity = activityVM.activity {
                    VStack(alignment: .center, spacing: 30)  {
                        Text(activity.title.localized)
                            .font(.largeTitle)
                            .bold()
                        Text(activity.description.localized)
                            .lineSpacing(2)
                        QuoteComponent(quote: activity.quote)
                        Spacer()
                        HStack() {
                            if activity.order != 3 {
                                NavigationLink ("activity.continue.next.button") {
                                    ActivityView(ActivityViewModel(activity:
                                                                    activityVM.nextActivity()), data)
                                }
                                .padding()
                                .background {
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(.accent, lineWidth: 1)
                                }
                            }
                            Spacer()
                            CapibaraImage()
                        }
                    }
                    .padding(30)
                    .multilineTextAlignment(.center)
                }
                else {
                    Text("activity.quote.notAvailable")
                        .multilineTextAlignment(.center)
                        .font(.subheadline)
                        .foregroundStyle(.pink.opacity(0.7))
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("toolbar.closeActivity.button") {
                        activityVM.isExitRequested = true
                    }
                }
            }
            .alert("alert.exitActivity.title", isPresented: $activityVM.isExitRequested) {
                Button("alert.yes.button") {
                    data.closeBook()
                    activityVM.isExitRequested = false
                }
                Button("alert.no.button") {
                    data.closeBook()
                    activityVM.isExitRequested = false
                }
                Button("alert.cancel.button") {
                    activityVM.isExitRequested = false
                }
            } message: {
                Text("alert.exitActivity.message")
            }
        }
    }
}

#Preview("Activity 0") {
    @Previewable @StateObject var auth = UserAuthViewModel()
    @Previewable @StateObject var database = DBViewModel()
    
    NavigationStack {
        ActivityView(.init(
            activity: ActivityModel(
                quote: database.quotesCollection.first?.value ?? .sample,
                isFinished: false,
                title: "activity.title.0",
                description: "activity.description.0",
                order: 0)), .init())
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button("Debug action") {
                    Task {
                        await auth.signInAnonymously()
                        await database.fetchQuote(with: "Book1_Unit1_Section1_Quote1")
                    }
                }
            }
        }
        .alert("Error auth", isPresented: $auth.hasError) {
            Button("OK") {
                
            }
        }
    }
    .onDisappear {
        Task {
            await auth.signOut()
        }
    }
}
