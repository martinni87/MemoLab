//
//  ActivityViewModel.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 6/4/25.
//

import SwiftUI
import SwiftData

final class ActivityViewModel: ObservableObject {
    @Published var activity: ActivityModel?
    @Published private var quote: Quote?
    @Published var isExitRequested: Bool = false
    @Query private var quotesList: [QuoteDataModel]
    
    init(activity: ActivityModel? = nil) {
        self.activity = activity
    }
    
    public func nextActivity() -> ActivityModel? {
        guard let currentActivity = activity else {
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
