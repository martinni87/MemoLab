//
//  WelcomeToActivitiesView.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 26/1/25.
//

import SwiftUI

struct WelcomeToActivitiesView: View {
    
    @ObservedObject var auth: UserAuthViewModel
    @ObservedObject var data: DBViewModel
    @StateObject var activityVM = ActivityViewModel()
    let quote: Quote
    
    @State var startActivities: Bool = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 50) {
                    Text("activities.welcome.message").setMLTextStyle(.body)
                    Button {
                        startActivities.toggle()
                    } label: {
                        VStack{
                            Image("IconStartActivity").applyMLImageStyle()
                            Text("activities.welcome.start.button")
                                .applyMLButtonStyle(.link)
                        }
                    }
                }
                .padding(30)
            }
            .fullScreenCover(isPresented: $startActivities) {
                ActivityView(
                    ActivityViewModel(
                        activity:
                            ActivityModel(
                                quote: quote,
                                isFinished: false,
                                title: "activity.title.0",
                                description: "activity.description.0",
                                order: 0)), data)
            }
            .navigationTitle("navigation.title.activities")
            .navigationBarTitleDisplayMode(.large)
            .scrollIndicators(.never)
            .toolbar {
                MLCloseSheetViewComponent(data: data)
            }
        }
    }
}

#Preview {
    WelcomeToActivitiesView(auth: .init(), data: .init(), quote: .sample)
}
