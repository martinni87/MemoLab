//
//  RegisterVerificationView.swift
//  MemoLab
//
//  Created by Martín Antonio Córdoba Getar on 1/4/25.
//

import SwiftUI

struct EmailVerificationModal: View {
    
    @ObservedObject var auth: UserAuthViewModel
    @ObservedObject var data: DBViewModel
    @ObservedObject var form: BaseAuthForm
    @State var cancelRequest: Bool = false
    @Environment(\.dismiss) var dismiss
    
    init(_ auth: UserAuthViewModel, _ data: DBViewModel, _ form: BaseAuthForm) {
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
                    Circle()
                        .stroke(.black, lineWidth: 1)
                        .frame(height: 200)
                        .background {
                            Circle()
                                .foregroundStyle(.gray.opacity(0.5))
                        }
                        .overlay {
                            Image("IconVerificationEmail")
                                .applyMLImageStyle(size: 150)
                                .offset(x: -10, y: -3)
                        }
                    Button {
                        Task {
                            await auth.signIn(with: .init(email: form.emailField.text, password: form.passwordField.text))
                        }
                    } label: {
                        Text("form.continue.button")
                            .applyMLButtonStyle()
                    }
                    Button {
                        Task {
                            await auth.sendVerificationEmail()
                        }
                    } label: {
                        Text("form.verify.button")
                            .applyMLButtonStyle(.link)
                    }
                }
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
    EmailVerificationModal(.init(), .init(), LoginFormViewModel())
}
