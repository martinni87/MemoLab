//
//  RegisterVerificationView.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 1/4/25.
//

import SwiftUI

struct RegisterVerificationView: View {
    
    @ObservedObject var auth: UserAuthViewModel
    @ObservedObject var data: DBViewModel
    @ObservedObject var form: RegisterFormViewModel
    @State var cancelRequest: Bool = false
    @Environment(\.dismiss) var dismiss
    
    init(_ auth: UserAuthViewModel, _ data: DBViewModel, _ form: RegisterFormViewModel) {
        self.auth = auth
        self.data = data
        self.form = form
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                VStack(spacing: 50){
                    Text("form.verificationMail.title")
                        .font(.largeTitle)
                        .bold()
                    Text("form.verificationMail.message")
                        .multilineTextAlignment(.leading)
                        .lineSpacing(1.5)
                }
                Spacer()
                MLTextFieldViewComponent(label: form.verificationMail.label, hint: form.verificationMail.hint, text: $form.verificationMail.text, error: $form.verificationMail.error)
                Button {
                    form.confirmVerificationCode()
                } label: {
                    Text("form.verify.button")
                        .applyMLButtonStyle()
                }
                Button {
                    
                } label: {
                    Text("form.resendVerificationCode.link")
                        .applyMLButtonStyle(.link)
                }
                Spacer()
            }
            .toolbar {
                Button {
                    cancelRequest.toggle()
                } label: {
                    Image(systemName: "xmark.circle.fill")
                }
                .foregroundStyle(.colorButtonPrimary)
            }
            .padding()
            .alert("alert.cancelProcess.title", isPresented: $cancelRequest) {
                Button("alert.yes.button") {
                    dismiss()
                }
                Button("alert.no.button") {}
            } message: {
                Text("alert.cancelProcess.message")
            }
        }
    }
}

#Preview {
    RegisterVerificationView(.init(), .init(), .init())
}
