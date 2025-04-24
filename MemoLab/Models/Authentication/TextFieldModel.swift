//
//  TextFieldModel.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 30/3/25.
//

import Foundation

struct TextFieldModel {
    var label: String = ""
    var hint: String = ""
    var text: String = ""
    var error: MLFormError? = nil
}
