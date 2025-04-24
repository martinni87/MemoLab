//
//  WordEntity.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 24/4/25.
//

import Foundation

struct WordEntity: Identifiable, Hashable, Equatable {
    let id = UUID()
    let word: String
    let originalOrder: Int
    var newOrder: Int?
    var startsHidden: Bool = false
    var isSelected: Bool = false
}

extension WordEntity {
    var orderSelectedIsCorrect: Bool {
        guard let newOrder = newOrder else { return false }
        return originalOrder == newOrder
    }
}
