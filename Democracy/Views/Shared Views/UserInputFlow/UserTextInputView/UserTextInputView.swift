//
//  CreatePasswordView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 10/1/23.
//

import SwiftUI

struct UserTextInputView<ViewModel: UserTextInputViewModel, Content: View>: View {
    @ObservedObject var viewModel: ViewModel
    @ViewBuilder let content: Content
    
    init(
        viewModel: ViewModel,
        @ViewBuilder content: () -> Content
    ) {
        self.viewModel = viewModel
        self.content = content()
    }
    
    var body: some View {
        primaryContent
            .onSubmit { // Note: Only needed for user text input screens.
                if viewModel.canSubmit {
                    performAsnycTask(
                        action: { await submit() },
                        isShowingProgress: $viewModel.isShowingProgress
                    )
                }
            }
    }
}

// MARK: - Subviews
private extension UserTextInputView {
    
    var primaryContent: some View {
        UserInputScreen(viewModel: viewModel) {
            VStack(alignment: .leading, spacing: ViewConstants.elementSpacing) {
                UserInputTitle(title: viewModel.title)
                
                VStack(alignment: .leading, spacing: ViewConstants.smallElementSpacing) {
                    content
                        .titledElement(title: viewModel.subtitle)
                    
                    requirements
                }
                nextButton
            }
        }
    }
    
    var nextButton: some View {
        NextButton(
            isShowingProgress: $viewModel.isShowingProgress,
            nextAction: submit,
            isDisabled: !viewModel.canSubmit
        )
    }
    
    var requirements: some View {
        FieldRequirementsView<ViewModel.Field>(
            allPossibleErrors: viewModel.allErrors,
            text: viewModel.text,
            currentInputErrors: viewModel.textErrors
        )
    }
}

// MARK: - Helper Methods
private extension UserTextInputView {
    func submit() async {
        withAnimation {
            viewModel.text = viewModel.text.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        await viewModel.submit()
    }
}

// MARK: - Preview
#Preview {
    let viewModel = EmailInputViewModel(coordinator: OnboardingCoordinator.preview, onboardingInput: .init())
    return UserTextInputView(viewModel: viewModel) {
        TextField(
            "Field Title",
            text: .constant("Hello World"),
            prompt: Text("Field Title").foregroundColor(.tertiaryBackground)
        )
        .textFieldStyle(EmailTextFieldStyle(email: .constant("emailText")))
    }
}
