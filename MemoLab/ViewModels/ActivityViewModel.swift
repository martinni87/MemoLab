//
//  ActivityViewModel.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 6/4/25.
//

import Foundation

final class ActivityViewModel: ObservableObject {
    @Published var activity: ActivityModel?
    
    init(activity: ActivityModel? = nil) {
        self.activity = activity
    }
}
