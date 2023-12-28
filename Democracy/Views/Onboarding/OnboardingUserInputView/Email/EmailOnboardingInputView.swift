//
//  EmailOnboardingInputView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/4/23.
//

import SwiftUI

struct EmailOnboardingInputView: UserInputView {
    @ObservedObject var viewModel: EmailInputViewModel
    @FocusState private var focusedField: OnboardingInputField?
    
    init(viewModel: EmailInputViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        main
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
    
    var isShowingProgress: Binding<Bool> {
        $viewModel.isShowingProgress
    }
    
    var onboardingAlert: Binding<NewAlertModel?> {
        $viewModel.alertModel
    }
    
    var field: some View {
        TextField(
            viewModel.fieldTitle,
            text: $viewModel.text,
            prompt: Text(viewModel.fieldTitle).foregroundColor(.tertiaryBackground)
        )
        .textFieldStyle(EmailTextFieldStyle(email: $viewModel.text))
        .focused($focusedField, equals: viewModel.field)
        .submitLabel(.next)
        .onTapGesture {
            focusedField = .email
        }
    }
}

// MARK: - Preview
#Preview {
    let parentCoordinator = RootCoordinator()
    let coordinator = OnboardingCoordinator(parentCoordinator: parentCoordinator)
    let viewModel = EmailInputViewModel(
        coordinator: coordinator,
        onboardingInput: .init()
    )
    return EmailOnboardingInputView(viewModel: viewModel)
}
