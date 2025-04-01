////
////  LoginFormViewComponent.swift
////  MemoLab
////
////  Created by Martín Antonio Córdoba Getar on 20/3/25.
////
//
//import SwiftUI
//
//struct TextFieldData {
//    var label: String = ""
//    var hint: String = ""
//    var text: String = ""
//    var errorMsg: String = ""
//    var hasError: Bool = false
//    var isSecure: Bool = false
//    var isHidden: Bool = false
//    var isMandatory: Bool = false
//    var regexToCheck: String = ""
//}
//
//struct TextFieldViewComponent: View {
//    
//    @ObservedObject var viewModel: TextFieldViewModel
//    @State var text = ""
//    
//    init(_ viewModel: TextFieldViewModel = TextFieldViewModel(TextFieldData())) {
//        self.viewModel = viewModel
//    }
//    
//    var body: some View {
//        VStack(alignment: .leading, spacing: 8){
//            Text(viewModel.data.label.localized)
//                .font(.subheadline)
//                .bold()
//                .foregroundStyle(.gray)
//            ZStack(alignment: .trailing){
//                Group {
//                    if viewModel.data.isHidden {
//                        SecureField(viewModel.data.hint.localized, text: $viewModel.data.text)
//                    } else {
//                        TextField(viewModel.data.hint.localized, text: $viewModel.data.text)
//                    }
//                }
//                .onChange(of: viewModel.data.text, { oldValue, newValue in
//                    viewModel.resetError()
//                })
//                .onSubmit {
//                    viewModel.validate()
//                }
//                .foregroundStyle(.accent)
//                .bold()
//                .padding()
//                .frame(height: 50)
//                .background {
//                    RoundedRectangle(cornerRadius: 8)
//                        .stroke(lineWidth: 1)
//                        .foregroundStyle(viewModel.data.hasError ? .red : .gray)
//                }
//                .background {
//                    RoundedRectangle(cornerRadius: 8)
//                        .fill(viewModel.data.hasError ? .red.opacity(0.15) : Color(uiColor: .systemGray5))
//                }
//                HStack {
//                    if viewModel.data.isSecure {
//                        Button {
//                            viewModel.data.isHidden.toggle()
//                        } label: {
//                            if viewModel.data.isHidden {
//                                Image(systemName: "eye")
//                            } else {
//                                Image(systemName: "eye.slash")
//                            }
//                        }
//                    }
//                    Button {
//                        viewModel.cleanField()
//                    } label: {
//                        Image(systemName: "xmark.circle")
//                    }
//                }
//                .padding()
//
//            }
//            Text(viewModel.data.hasError ? viewModel.data.errorMsg : "")
//                .font(.caption)
//                .fontWeight(.semibold)
//                .foregroundStyle(.red)
//                .multilineTextAlignment(.leading)
//                .lineLimit(2)
//        }
//    }
//}
//
//class TextFieldViewModel: ObservableObject {
//    
//    @Published var data: TextFieldData
//    @Published var textFieldIsValid = false
//    
//    init(_ data: TextFieldData) {
//        self.data = data
//    }
//    
//    func cleanField() {
//        data.text = ""
//        resetError()
//    }
//    
//    func resetError() {
//        data.errorMsg = ""
//        data.hasError = false
//    }
//    
//    func resetAll() {
//        cleanField()
//        textFieldIsValid = false
//    }
//    
//    func validate() {
//        if data.isMandatory {
//            if data.text.isEmpty {
//                data.errorMsg = "Este campo es obligatorio"
//                data.hasError = true
//                return
//            }
//        }
//        if !data.regexToCheck.isEmpty {
//            let pattern = data.regexToCheck
//            let predicate = NSPredicate(format: "SELF MATCHES[c] %@", pattern)
//            let textIsValid = predicate.evaluate(with: data.text)
//            
//            if !textIsValid {
//                data.errorMsg = "Formato no válido"
//                data.hasError = true
//                return
//            }
//        }
//        textFieldIsValid = true
//    }
//}
