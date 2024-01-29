//
//  UsernameOnboardingInputView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/4/23.
//

import SwiftUI

struct UsernameOnboardingInputView<ViewModel: UsernameInputViewModel>: View {
    @Bindable var viewModel: ViewModel
    @FocusState private var focusedField: ViewModel.Flow?
    @State private var isFirstAppear = true
    
    var body: some View {
        UserTextInputView(
            viewModel: viewModel,
            focusedField: $focusedField,
            shouldOverrideOnAppear: true) {
                field
            }
            .onAppear {
                if isFirstAppear {
                    focusedField = viewModel.flowCase
                    isFirstAppear = false
                } else {
                    Task {
                        // Note: Keyboard jumps to mid screen without this sleep,
                        // when dismissing a view above in the stack.
                        try await Task.sleep(seconds: 0.5)
                        focusedField = viewModel.flowCase
                    }
                }
            }
    }
}

// MARK: - Subviews
private extension UsernameOnboardingInputView {
    var field: some View {
        DefaultTextInputField(
            text: $viewModel.text,
            textFieldStyle: UsernameTextFieldStyle(
                username: $viewModel.text,
                focusedField: $focusedField,
                field: .username
            ),
            fieldTitle: viewModel.fieldTitle,
            requirementType: ViewModel.Requirement.self
        )
    }
}

// MARK: - Preview
#Preview {
    let viewModel = UsernameInputViewModel(
        coordinator: OnboardingCoordinator.preview
    )
    return UsernameOnboardingInputView(viewModel: viewModel)
}
