//
//  PasswordOnboardingInputView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/4/23.
//

import SwiftUI

struct PasswordOnboardingInputView: UserInputView {
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
}

// MARK: - Subviews and Computed Properties
extension PasswordOnboardingInputView {
    
    var isShowingProgress: Binding<Bool> {
        $viewModel.isShowingProgress
    }
    
    var onboardingAlert: Binding<AlertModel?> {
        $viewModel.alertModel
    }
    
    var field: some View {
        CustomSecureField(secureText: $viewModel.text, loginField: $focusedField, isNewPassword: true)
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
