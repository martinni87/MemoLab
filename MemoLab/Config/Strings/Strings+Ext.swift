//
//  Strings+Ext.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 27/3/25.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
}
