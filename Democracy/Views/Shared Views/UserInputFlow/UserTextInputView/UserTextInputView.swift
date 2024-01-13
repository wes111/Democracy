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
        UserInputScreen(viewModel: viewModel, additionalSubmitAction: submit) {
            content
        }
        .onSubmit {
            if viewModel.canSubmit {
                performAsnycTask(
                    action: { await submit() },
                    isShowingProgress: $viewModel.isShowingProgress
                )
            }
        }
    }
}

// MARK: - Helper Methods
private extension UserTextInputView {
    func submit() async {
        withAnimation {
            viewModel.text = viewModel.text.trimmingCharacters(in: .whitespacesAndNewlines)
        }
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
