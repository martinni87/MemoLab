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
    @State var hasInfo: Bool = false
    var infoMessage: String = ""
    @State private var showInfo: Bool = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                Text(label.localized)
                    .font(.subheadline)
                    .bold()
                    .foregroundStyle(.gray)
                if hasInfo {
                    Button {
                        DispatchQueue.main.asyncAfter(deadline: .now()) {
                            withAnimation(.easeIn) {
                                showInfo = true
                            }
                        }
                    } label: {
                        Image(systemName: "info.circle")
                    }
                }
            }
            ZStack(alignment: .trailing){
                if isHidden {
                    SecureField("form.password.hint", text: $text)
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
            .autocorrectionDisabled(true)
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
            
            if hasInfo && showInfo {
                RoundedRectangle(cornerRadius: 8)
                    .stroke(style: StrokeStyle(lineWidth: 1))
                    .frame(height: 100)
                    .background(Color(uiColor: .systemBackground))
                    .shadow(radius: 5)
                    .overlay {
                        VStack(spacing: 5){
                            Text(infoMessage.localized)
                                .padding()
                            Button("info.ok.action") {
                                DispatchQueue.main.asyncAfter(deadline: .now()) {
                                    withAnimation(.easeOut) {
                                        showInfo = false
                                    }
                                }
                            }
                        }
                        .multilineTextAlignment(.center)
                        .lineLimit(3)
                        .font(.caption)
                    }
                    .padding(.bottom, 50)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                            withAnimation(.easeOut) {
                                showInfo = false
                            }
                        }
                    }
            }
        }
    }
}

#Preview {
    @Previewable @State var text: String = ""
    @Previewable @State var error: MLFormError? = .fieldIsEmpty
    MLTextFieldViewComponent(label: "form.email.label", hint: "form.email.hint", text: $text, error: $error)
        .padding()
}
