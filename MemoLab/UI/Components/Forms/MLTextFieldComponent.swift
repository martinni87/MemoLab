//
//  MLTextField.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 19/3/25.
//

import SwiftUI

struct MLTextFieldComponent: View {
    
    @StateObject var viewModel: MLTextFieldViewModel = .init(label: "Username", text: "", hint: "johnDoe87", isMandatory: true)
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10){
            Text(viewModel.model.label)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(.gray)
            Rectangle()
                .foregroundStyle(viewModel.model.fieldColor)
                .frame(width: .infinity, height: 50)
                .clipShape(.buttonBorder)
                .shadow(color: viewModel.model.fieldColor, radius: 2, x: 0, y: 0)
                .overlay {
                    TextField(text: $viewModel.model.text) {
                        Text(viewModel.model.hint)
                            .foregroundStyle(viewModel.model.hintColor)
                            .italic()
                            .fontWeight(.medium)
                    }
                    .foregroundStyle(viewModel.model.inputColor)
                    .fontWeight(.bold)
                    .onSubmit {
                        viewModel.validate()
                    }
                    .onChange(of: viewModel.model.text, { oldValue, newValue in
                        viewModel.resetErrors()
                    })
                    .padding()
                }
            Text(viewModel.model.errorMsg)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundStyle(viewModel.model.errorColor)
                .multilineTextAlignment(.leading)
                .lineLimit(1)
        }
        Button("Submit") {
            viewModel.validate()
        }
    }
}

struct MLTextFieldModel {
    var label: String
    var text: String
    var hint: String
    var hasError: Bool = false
    var errorMsg: String = "No error"
    var isMandatory: Bool = false
    var fieldColor: Color {
        hasError ? Color(uiColor: .systemRed).opacity(0.15) : Color(uiColor: .systemGray5)
    }
    var hintColor: Color {
        hasError ? Color(uiColor: .systemRed) : Color(uiColor: .systemGray)
    }
    var inputColor: Color {
        hasError ? Color(uiColor: .systemRed) : .accent
    }
    var errorColor: Color {
        hasError ? Color(uiColor: .systemRed) : .clear
    }
}

final class MLTextFieldViewModel: ObservableObject {
    @Published var model: MLTextFieldModel
    
    init(label: String, text: String, hint: String, hasError: Bool = false, errorMsg: String = "No error", isMandatory: Bool = false) {
        self.model = .init(label: label,
                           text: text,
                           hint: hint,
                           hasError: hasError,
                           errorMsg: errorMsg,
                           isMandatory: isMandatory)
    }
    
    func validate() {
        if model.isMandatory && model.text.isEmpty {
            model.hasError = true
            model.errorMsg = "This field is mandatory"
        }
    }
    
    func resetErrors() {
        model.hasError = false
        model.errorMsg = "No error"
    }
}

#Preview {
    MLTextFieldComponent()
}
