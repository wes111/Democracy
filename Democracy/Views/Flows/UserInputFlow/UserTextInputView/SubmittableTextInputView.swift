//
//  CreatePasswordView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/1/23.
//

import SwiftUI

@MainActor
struct SubmittableTextInputView<ViewModel: SubmittableTextInputViewModel, Content: View>: View {
    @Bindable var viewModel: ViewModel
    @ViewBuilder let content: Content
    
    init(viewModel: ViewModel, @ViewBuilder content: () -> Content) {
        self.viewModel = viewModel
        self.content = content()
    }
    
    var body: some View {
        content
            .onSubmit {
                if viewModel.canPerformNextAction {
                    performAsnycTask(
                        action: {
                            await submit()
                            await viewModel.nextButtonAction()
                        },
                        isShowingProgress: $viewModel.isShowingProgress
                    )
                }
            }
            .dismissKeyboardOnDrag()
    }
}

// MARK: - Helper Methods
private extension SubmittableTextInputView {
    func submit() async {
        withAnimation {
            viewModel.text = viewModel.text.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
}

// MARK: - Preview
#Preview {
    @FocusState var focusedField: AccountFlow.ID?
    
    return SubmittableTextInputView(viewModel: AccountEmailViewModel.preview) {
        TextField(
            "Field Title",
            text: .constant("Hello World"),
            prompt: Text("Field Title").foregroundColor(.tertiaryBackground)
        )
        .textFieldStyle(EmailTextFieldStyle(
            email: .constant("Email Text"),
            focusedField: $focusedField,
            field: .email
        ))
    }
}
