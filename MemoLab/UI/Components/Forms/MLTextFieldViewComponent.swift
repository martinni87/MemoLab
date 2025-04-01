//
//  MLTextFieldViewComponent.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 30/3/25.
//

import SwiftUI

struct MLTextFieldViewComponent: View {
    
    var label: String = ""
    var hint: String = ""
    @Binding var text: String
    @Binding var error: MLFormError?
    var isSecure: Bool = false
    @State var isHidden: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(label.localized)
                .font(.subheadline)
                .bold()
                .foregroundStyle(.gray)
            ZStack(alignment: .trailing){
                if isHidden {
                    SecureField("", text: $text)
                } else {
                    TextField(hint.localized, text: $text)
                }
                HStack {
                    if isSecure {
                        Button {
                            isHidden.toggle()
                        } label: {
                            Image(systemName: isHidden ? "eye" : "eye.slash")
                        }
                    }
                    Button {
                        text = ""
                        error = nil
                    } label: {
                        Image(systemName: "xmark.circle")
                    }
                }
            }
            .scrollDismissesKeyboard(.immediately)
            .onChange(of: text, { oldValue, newValue in
                error = nil
            })
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            .foregroundStyle(.accent)
            .bold()
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 8)
                    .foregroundStyle(error != nil ? .red.opacity(0.15) : Color(uiColor: .systemGray5))
            }
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(error != nil ? .red : .gray, lineWidth: 1)
            }
            Text(error?.localized ?? "")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.red)
                .multilineTextAlignment(.leading)
                .lineLimit(2)
                .frame(height: 25)
        }
    }
}

#Preview {
    @Previewable @State var text: String = ""
    @Previewable @State var error: MLFormError? = .fieldIsEmpty
    MLTextFieldViewComponent(label: "form.email.label", hint: "form.email.hint", text: $text, error: $error)
        .padding()
}
