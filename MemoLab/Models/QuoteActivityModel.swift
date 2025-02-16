//
//  QuoteActivityModel.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 2/2/25.
//

import Foundation

enum QuoteActivity: String, Identifiable {
    case activityOne = "Actividad 1"
    case activityTwo = "Actividad 2"
    case activityThree = "Actividad 3"
    
    var id: String {
        self.rawValue
    }
}
