//
//  PasswordOnboardingInputView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/4/23.
//

import SwiftUI

struct PasswordOnboardingInputView: View {
    @Bindable var viewModel: PasswordInputViewModel
    @FocusState private var focusedField: OnboardingInputField?
    
    init(viewModel: PasswordInputViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        UserTextInputView(viewModel: viewModel, focusedField: $focusedField) {
            field
        }
    }
}

// MARK: - Subviews and Computed Properties
extension PasswordOnboardingInputView {
    
    var field: some View {
        CustomSecureField(
            secureText: $viewModel.text,
            loginField: $focusedField,
            isNewPassword: true,
            field: .password
        )
        .requirements(
            text: $viewModel.text,
            requirementType: PasswordRequirement.self,
            field: viewModel.field
        )
        .focused($focusedField, equals: viewModel.field)
        .submitLabel(.next)
        .onTapGesture {
            focusedField = .password
        }
    }
}

// MARK: - Preview
#Preview {
    let viewModel = PasswordInputViewModel(
        coordinator: OnboardingCoordinator.preview,
        onboardingInput: .init()
    )
    return PasswordOnboardingInputView(viewModel: viewModel)
}
