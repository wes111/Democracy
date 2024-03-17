//
//  PhoneOnboardingInputView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/4/23.
//

import SwiftUI

@MainActor
struct AccountPhoneView<ViewModel: AccountPhoneViewModel>: View {
    @Bindable var viewModel: ViewModel
    @FocusState private var focusedField: ViewModel.FocusedField?
    
    var body: some View {
        primaryContent
            .onAppear {
                viewModel.onAppear()
            }
    }
}

// MARK: - Subviews
private extension AccountPhoneView {
    
    var primaryContent: some View {
        SubmittableTextInputView(viewModel: viewModel, focusedField: $focusedField) {
            VStack {
                field
                Spacer()
                SubmittableNextAndSkipButtons(viewModel: viewModel)
            }
        }
    }
    
    var field: some View {
        DefaultTextInputField(
            text: $viewModel.text,
            textFieldStyle: PhoneTextFieldStyle(
                phone: $viewModel.text,
                focusedField: $focusedField,
                field: .phone
            ),
            fieldTitle: viewModel.fieldTitle,
            requirementType: ViewModel.Requirement.self
        )
    }
}

// MARK: - Preview
#Preview {
    AccountPhoneView(viewModel: .preview)
}
