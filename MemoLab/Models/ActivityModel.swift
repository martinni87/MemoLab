//
//  QuoteActivityModel.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 2/2/25.
//

import Foundation

enum ActivitySet: String, Identifiable, CaseIterable {
    case activityZero
    case activityOne
    case activityTwo
    case activityThree
    
    var id: String {
        self.rawValue
    }
    
    var order: String {
        let list = Array(ActivitySet.allCases)
        var order = "0"
        for index in 1...list.count {
            if list[index].id == self.id {
                order = String(index)
            }
        }
        return order
    }
    
    var name: String {
        let list = Array(ActivitySet.allCases)
        var name = ""
        if self != .activityZero {
            for index in 1...list.count {
                if list[index].id == self.id {
                    name = "Actividad \(index)"
                }
            }
        } else {
            name = "Primer contacto"
        }
        return name
    }
}

struct ActivityModel {
    let activity: ActivitySet
    let quote: Quote
    var isFinished: Bool = false
    var title: String { activity.name }
    var order: String { activity.order }
}
