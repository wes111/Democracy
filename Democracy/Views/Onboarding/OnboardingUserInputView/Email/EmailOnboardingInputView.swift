//
//  EmailOnboardingInputView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/4/23.
//

import SwiftUI

struct EmailOnboardingInputView: View, OnboardingInputView {
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
    
    var isShowingProgress: Binding<Bool> {
        $viewModel.isShowingProgress
    }
    
    var onboardingAlert: Binding<OnboardingAlert?> {
        $viewModel.onboardingAlert
    }
    
    var field: some View {
        TextField(
            viewModel.fieldTitle,
            text: $viewModel.text,
            prompt: Text(viewModel.fieldTitle).foregroundColor(.secondaryBackground)
        )
        .textFieldStyle(EmailTextFieldStyle(email: $viewModel.text))
        .focused($focusedField, equals: viewModel.field)
        .submitLabel(.next)
        .onTapGesture {
            focusedField = .email
        }
    }
}

#Preview {
    let parentCoordinator = RootCoordinator()
    let coordinator = OnboardingCoordinator(parentCoordinator: parentCoordinator)
    let viewModel = EmailInputViewModel(
        coordinator: coordinator,
        onboardingInput: .init()
    )
    return EmailOnboardingInputView(viewModel: viewModel)
}
