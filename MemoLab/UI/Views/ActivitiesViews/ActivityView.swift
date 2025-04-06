//
//  ActivityZeroView.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 2/2/25.
//

import SwiftUI
import SwiftData

struct ActivityView: View {
    
    @ObservedObject var activityViewModel: ActivityViewModel
    
    init(_ activity: ActivityViewModel) {
        self.activityViewModel = activity
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                if let activity = activityViewModel.activity {
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
                                                                    nextActivity()))
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
                    MLDismissViewComponent()
                }
            }
        }
        
    }
    
    private func nextActivity() -> ActivityModel? {
        guard let currentActivity = activityViewModel.activity else {
            return nil
        }
        guard currentActivity.order != 3 else {
            return nil
        }
        let newActivityOrder = currentActivity.order + 1
        return ActivityModel(quote: currentActivity.quote,
                             isFinished: false,
                             title: "activity.title.\(newActivityOrder)",
                             description: "activity.description.\(newActivityOrder)",
                             order: newActivityOrder)
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
                order: 0)))
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
