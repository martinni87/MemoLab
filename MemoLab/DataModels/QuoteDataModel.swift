//
//  UserQuote.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 8/4/25.
//

import Foundation
import SwiftData

@Model
class QuoteDataModel: Identifiable, Hashable {
    @Attribute(.unique) var id: String
    var userId: String
    var text: String
    var author: String?
    var progress: Double
    var isFinished: Bool

    init(from quote: Quote, userId: String) {
        self.id = quote.id
        self.userId = userId
        self.text = quote.text
        self.author = quote.author
        self.progress = 0.0
        self.isFinished = false
    }
    
    func updateProgress(_ value: Double) {
        progress = min(value, 1.0)
        isFinished = progress >= 1.0
    }
}
