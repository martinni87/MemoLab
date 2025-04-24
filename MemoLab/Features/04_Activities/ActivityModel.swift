//
//  QuoteActivityModel.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 2/2/25.
//

import Foundation

struct ActivityModel {
    var quote: Quote
    var isFinished: Bool = false
    var title: String = ""
    var description: String = ""
    var order: Int = 0
}
