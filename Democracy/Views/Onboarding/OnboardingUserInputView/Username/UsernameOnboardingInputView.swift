//
//  UsernameOnboardingInputView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/4/23.
//

import SwiftUI

struct UsernameOnboardingInputView: OnboardingInputView {
    
    @ObservedObject var viewModel: UsernameInputViewModel
    @FocusState private var focusedField: OnboardingInputField?
    
    init(viewModel: UsernameInputViewModel) {
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
        .textFieldStyle(UsernameTextFieldStyle(username: $viewModel.text))
        .focused($focusedField, equals: viewModel.field)
        .submitLabel(.next)
        .onTapGesture {
            focusedField = .username
        }
    }
}

// MARK: - Preview
#Preview {
    let parentCoordinator = RootCoordinator()
    let coordinator = OnboardingCoordinator(parentCoordinator: parentCoordinator)
    let viewModel = UsernameInputViewModel(
        coordinator: coordinator
    )
    return UsernameOnboardingInputView(viewModel: viewModel)
}
