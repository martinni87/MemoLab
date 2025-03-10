//
//  WelcomeToActivitiesView.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 26/1/25.
//

import SwiftUI

struct WelcomeToActivitiesView: View {
    
    @ObservedObject var data: DBViewModel
    let quote: Quote
    
    @State var startActivities: Bool = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 50) {
                    Text("activity0_welcome").setMLTextStyle(.body)
                    Button {
                        
                    } label: {
                        MLButton("¡Comencemos!", style: .image, imageResource: "IconStartActivity") {
                            startActivities.toggle()
                        }
                    }
                }
                .padding(30)
            }
            .fullScreenCover(isPresented: $startActivities) {
                ActivityZeroView(quote: quote)
            }
            .navigationTitle("Actividades")
            .navigationBarTitleDisplayMode(.large)
            .scrollIndicators(.never)
            .toolbar {
                MLCloseBookSheetViewComponent(data: data)
            }
        }
    }
}
//            ScrollView {
//                VStack(spacing: 30){
//                    Text("activity0_welcome").setMLTextStyle(.body)
//                    Text("activity0_description").setMLTextStyle(.body)
//                    VStack {
//                        Text(quote.text)
//                    }
//                    .multilineTextAlignment(.center)
//                    .padding()
//                    .background{
//                        Rectangle()
//                            .fill(.colorPaper)
//                            .shadow(radius: 10)
//                    }
//                    .lineSpacing(15)
//                    .padding(.vertical)
//                        
//
//                    HStack(spacing: 40) {
//                        Group {
//                            Button("1") {
//                                activityChoosen = .activityOne
//                            }
//                            Button("2") {
//                                activityChoosen = .activityTwo
//                            }
//                            Button("3") {
//                                activityChoosen = .activityThree
//                            }
//                        }
//                        .buttonStyle(BorderedButtonStyle())
//                        .buttonBorderShape(.circle)
//                        .tint(.colorButtonPrimary)
//                    }
//                    .scaleEffect(2)
//                    .padding()
//                }
//            }
//            .fullScreenCover(item: $activityChoosen) { activity in
//                switch activity {
//                case .activityOne:
//                    ActivityOneView(data: data, quote: quote)
//                case .activityTwo:
//                    ActivityTwoView(data: data, quote: quote)
//                case .activityThree:
//                    ActivityThreeView(data: data, quote: quote)
//                }
//            }
//            .padding(40)
//            .navigationTitle("Actividades")
//            .toolbar {
//                MLCloseBookSheetViewComponent(data: data)
//            }
//        }
//    }
//}

#Preview {
    WelcomeToActivitiesView(data: DBViewModel(), quote: .sample)
}
