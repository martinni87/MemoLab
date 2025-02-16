//
//  MLCloseSheetViewComponent.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 6/2/25.
//

import SwiftUI

struct MLCloseBookSheetViewComponent: View {
    
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
    MLCloseBookSheetViewComponent(data: DBViewModel())
}
