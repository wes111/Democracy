//
//  EmailOnboardingInputView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/4/23.
//

import SwiftUI

struct EmailOnboardingInputView<ViewModel: EmailInputViewModel>: View {
    @ObservedObject var viewModel: ViewModel
    @FocusState private var focusedField: ViewModel.Field?
    
    var body: some View {
        DefaultTextFieldInputView(
            viewModel: viewModel,
            focusedField: $focusedField,
            textFieldStyle: EmailTextFieldStyle(
                email: $viewModel.text,
                focusedField: $focusedField,
                field: .email
            )
        )
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
