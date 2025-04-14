//
//  CapibaraImage.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 6/4/25.
//

import SwiftUI

struct CapibaraImage: View {
    
    private let size: CGFloat
    
    init(size: CGFloat = 150) {
        self.size = size
    }
    
    var body: some View {
        Image("Capibara\(randomNumber(in: 1...7))")
            .applyMLImageStyle(size: size)
    }
    
    private func randomNumber(in range: ClosedRange<Int>) -> Int {
        return Int.random(in: range)
    }
}

#Preview {
    CapibaraImage()
}
