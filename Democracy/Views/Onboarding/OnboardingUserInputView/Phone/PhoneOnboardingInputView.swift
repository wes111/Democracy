//
//  PhoneOnboardingInputView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/4/23.
//

import SwiftUI

struct PhoneOnboardingInputView<ViewModel: PhoneInputViewModel>: View {
    @ObservedObject var viewModel: ViewModel
    @FocusState private var focusedField: ViewModel.Field?
    
    var body: some View {
        DefaultTextFieldInputView(
            viewModel: viewModel,
            focusedField: $focusedField,
            textFieldStyle: PhoneTextFieldStyle(
                phone: $viewModel.text,
                focusedField: $focusedField,
                field: OnboardingInputField.phone
            )
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
