//
//  EmailOnboardingInputView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/4/23.
//

import SwiftUI

struct EmailOnboardingInputView: View {
    @ObservedObject var viewModel: EmailInputViewModel
    @FocusState private var focusedField: OnboardingInputField?
    
    init(viewModel: EmailInputViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        UserTextInputView(
            viewModel: viewModel,
            content: { field }
        )
        .onAppear {
            focusedField = viewModel.field
        }
        .onTapGesture {
            focusedField = nil
        }
    }
}

// MARK: - Subviews and Computed Properties
extension EmailOnboardingInputView {
    
    var field: some View {
        TextField(
            viewModel.fieldTitle,
            text: $viewModel.text,
            prompt: Text(viewModel.fieldTitle).foregroundColor(.tertiaryBackground)
        )
        .textFieldStyle(EmailTextFieldStyle(email: $viewModel.text))
        .requirements(
            text: viewModel.text,
            allPossibleErrors: viewModel.allErrors,
            textErrors: viewModel.textErrors
        )
        .focused($focusedField, equals: viewModel.field)
        .submitLabel(.next)
        .onTapGesture {
            focusedField = .email
        }
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
