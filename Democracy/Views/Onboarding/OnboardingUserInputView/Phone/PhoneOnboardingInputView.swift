//
//  PhoneOnboardingInputView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/4/23.
//

import SwiftUI

struct PhoneOnboardingInputView<ViewModel: PhoneInputViewModel>: View {
    @Bindable var viewModel: ViewModel
    @FocusState private var focusedField: ViewModel.Flow?
    
    var body: some View {
        UserTextInputView(
            viewModel: viewModel,
            focusedField: $focusedField) {
                field
            }
    }
}

private extension PhoneOnboardingInputView {
    var field: some View {
        DefaultTextInputField(
            text: $viewModel.text,
            textFieldStyle: PhoneTextFieldStyle(
                phone: $viewModel.text,
                focusedField: $focusedField,
                field: CreateAccountFlow.phone
            ),
            fieldTitle: viewModel.fieldTitle,
            requirementType: ViewModel.Requirement.self
        )
    }
}

// MARK: - Preview
#Preview {
    let viewModel = PhoneInputViewModel(
        coordinator: OnboardingCoordinator.preview,
        onboardingInput: .init()
    )
    return PhoneOnboardingInputView(viewModel: viewModel)
}
