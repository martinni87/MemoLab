//
//  GameModels.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 21/4/25.
//

import SwiftUI

struct QuoteFragment: Identifiable {
    let id = UUID()
    var text: String
    var originalOrder: Int  // 0, 1, 2, 3
    var isHidden: Bool = false
    var userSelectionOrder: Int? = nil  // El orden en que el usuario las seleccionó, si aplica
}


