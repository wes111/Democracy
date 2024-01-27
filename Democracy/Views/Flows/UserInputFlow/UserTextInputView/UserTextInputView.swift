//
//  CreatePasswordView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/1/23.
//

import SwiftUI

struct UserTextInputView<ViewModel: UserTextInputViewModel, Content: View>: View {
    @Bindable var viewModel: ViewModel
    @ViewBuilder let content: Content
    @FocusState.Binding var focusedField: ViewModel.Field?
    let shouldOverrideOnAppear: Bool
    
    init(
        viewModel: ViewModel,
        focusedField: FocusState<ViewModel.Field?>.Binding,
        shouldOverrideOnAppear: Bool = false,
        @ViewBuilder content: () -> Content
    ) {
        self.viewModel = viewModel
        self._focusedField = focusedField
        self.shouldOverrideOnAppear = shouldOverrideOnAppear
        self.content = content()
    }
    
    var body: some View {
        UserInputScreen(viewModel: viewModel, additionalSubmitAction: submit) {
            content
        }
        .onSubmit {
            if viewModel.canPerformNextAction {
                performAsnycTask(
                    action: {
                        await submit()
                        await viewModel.submit()
                    },
                    isShowingProgress: $viewModel.isShowingProgress
                )
            }
        }
        .onAppear {
            if !shouldOverrideOnAppear {
                focusedField = viewModel.field
            }
        }
        .dismissKeyboardOnDrag()
    }
}

// MARK: - Helper Methods
private extension UserTextInputView {
    func submit() async {
        withAnimation {
            viewModel.text = viewModel.text.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }
}

// MARK: - Preview
#Preview {
    let viewModel = EmailInputViewModel(coordinator: OnboardingCoordinator.preview, onboardingInput: .init())
    @FocusState var focusedField: OnboardingInputField?
    
    return UserTextInputView(
        viewModel: viewModel,
        focusedField: $focusedField
    ) {
        TextField(
            "Field Title",
            text: .constant("Hello World"),
            prompt: Text("Field Title").foregroundColor(.tertiaryBackground)
        )
        .textFieldStyle(EmailTextFieldStyle(
            email: .constant("Email Text"),
            focusedField: $focusedField,
            field: OnboardingInputField.email
        ))
    }
}
