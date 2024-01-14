//
//  UsernameOnboardingInputView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/4/23.
//

import SwiftUI

struct UsernameOnboardingInputView<ViewModel: UsernameInputViewModel>: View {
    @ObservedObject var viewModel: ViewModel
    @FocusState private var focusedField: ViewModel.Field.FieldCollection?
    @State private var isFirstAppear = true
    
    var body: some View {
        DefaultTextFieldInputView(
            viewModel: viewModel,
            focusedField: $focusedField,
            shouldOverrideOnAppear: true, // TODO: This should fix bug below
            textFieldStyle: UsernameTextFieldStyle(
                username: $viewModel.text,
                focusedField: $focusedField,
                textErrors: viewModel.textErrors
            )
        )
        .onAppear {
            if isFirstAppear {
                focusedField = viewModel.field
                isFirstAppear = false
            } else {
                Task {
                    // Note: Keyboard jumps to mid screen without this sleep,
                    // when dismissing a view above in the stack.
                    try await Task.sleep(seconds: 0.5)
                    focusedField = viewModel.field
                }
            }
        }
    }
}

// MARK: - Preview
#Preview {
    let viewModel = UsernameInputViewModel(
        coordinator: OnboardingCoordinator.preview
    )
    return UsernameOnboardingInputView(viewModel: viewModel)
}
