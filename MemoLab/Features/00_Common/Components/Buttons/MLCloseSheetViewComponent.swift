//
//  MLCloseSheetViewComponent.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 6/2/25.
//

import SwiftUI

struct MLCloseSheetViewComponent: View {
    
    @ObservedObject var data: DBViewModel

    var body: some View {
        Button {
            data.closeBook()
        } label: {
            Image(systemName: "xmark.circle.fill")
                .foregroundStyle(.colorButtonPrimary)
        }
    }
}

#Preview {
    MLCloseSheetViewComponent(data: DBViewModel())
}
