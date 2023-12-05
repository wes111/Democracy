//
//  PasswordOnboardingInputView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/4/23.
//

import SwiftUI

struct PasswordOnboardingInputView: View, OnboardingInputView {
    @ObservedObject var viewModel: PasswordInputViewModel
    @FocusState private var focusedField: OnboardingInputField?
    
    init(viewModel: PasswordInputViewModel) {
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
        CustomSecureField(secureText: $viewModel.text, loginField: $focusedField)
            .focused($focusedField, equals: viewModel.field)
            .submitLabel(.next)
            .onTapGesture {
                focusedField = .password
            }
    }
}

// MARK: - Preview
#Preview {
    let parentCoordinator = RootCoordinator()
    let coordinator = OnboardingCoordinator(parentCoordinator: parentCoordinator)
    let viewModel = PasswordInputViewModel(
        coordinator: coordinator,
        onboardingInput: .init()
    )
    return PasswordOnboardingInputView(viewModel: viewModel)
}
