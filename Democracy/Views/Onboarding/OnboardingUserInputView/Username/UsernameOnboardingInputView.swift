//
//  UsernameOnboardingInputView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/4/23.
//

import SwiftUI

struct UsernameOnboardingInputView: UserInputView {
    
    @ObservedObject var viewModel: UsernameInputViewModel
    @FocusState private var focusedField: OnboardingInputField?
    @State private var isFirstAppear = true
    
    init(viewModel: UsernameInputViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        main
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
            .onTapGesture {
                focusedField = nil
            }
    }
}

// MARK: Subviews and Computed Properties
extension UsernameOnboardingInputView {
    
    var isShowingProgress: Binding<Bool> {
        $viewModel.isShowingProgress
    }
    
    var onboardingAlert: Binding<AlertModel?> {
        $viewModel.alertModel
    }
    
    var field: some View {
        TextField(
            viewModel.fieldTitle,
            text: $viewModel.text,
            prompt: Text(viewModel.fieldTitle).foregroundColor(.tertiaryBackground)
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
