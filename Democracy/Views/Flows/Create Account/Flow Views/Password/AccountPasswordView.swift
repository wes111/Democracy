//
//  PasswordOnboardingInputView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/4/23.
//

import SwiftUI

@MainActor
struct AccountPasswordView<ViewModel: AccountPasswordViewModel>: View {
    @Bindable var viewModel: ViewModel
    @FocusState private var focusedField: ViewModel.FocusedField?
    
    var body: some View {
        primaryContent
            .onAppear {
                viewModel.onAppear()
            }
            .progressModifier(isShowingProgess: $viewModel.isShowingProgress)
            .alertableModifier(alertModel: $viewModel.alertModel)
    }
}

// MARK: - Subviews and Computed Properties
extension AccountPasswordView {
    
    var primaryContent: some View {
        SubmittableTextInputView(viewModel: viewModel, focusedField: $focusedField) {
            VStack {
                field
                Spacer()
                SubmittableNextButton(viewModel: viewModel)
            }
        }
    }
    
    var field: some View {
        CustomSecureField(
            secureText: $viewModel.text,
            loginField: $focusedField,
            isNewPassword: true,
            field: .password
        )
        .requirements(
            text: $viewModel.text,
            requirementType: ViewModel.Requirement.self
        )
        .focused($focusedField, equals: .password)
        .submitLabel(.next)
        .onTapGesture {
            focusedField = .password
        }
    }
}

// MARK: - Preview
#Preview {
    AccountPasswordView(viewModel: .preview)
}
