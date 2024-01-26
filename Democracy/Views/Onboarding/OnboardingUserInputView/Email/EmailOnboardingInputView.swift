//
//  EmailOnboardingInputView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/4/23.
//

import SwiftUI

struct EmailOnboardingInputView<ViewModel: EmailInputViewModel>: View {
    @Bindable var viewModel: ViewModel
    @FocusState private var focusedField: ViewModel.Field?
    
    var body: some View {
        UserTextInputView(
            viewModel: viewModel,
            focusedField: $focusedField) {
                field
            }
    }
}

// MARK: - Subviews
private extension EmailOnboardingInputView {
    var field: some View {
        DefaultTextInputField(
            viewModel: viewModel,
            textFieldStyle: EmailTextFieldStyle(
                email: $viewModel.text,
                focusedField: $focusedField,
                field: .email
            ))
    }
}

// MARK: - Preview
#Preview {
    let viewModel = EmailInputViewModel(
        coordinator: OnboardingCoordinator.preview,
        onboardingInput: .init()
    )
    return EmailOnboardingInputView(viewModel: viewModel)
}
