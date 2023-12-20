//
//  PhoneOnboardingInputView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/4/23.
//

import SwiftUI

struct PhoneOnboardingInputView: UserInputView {
    @ObservedObject var viewModel: PhoneInputViewModel
    @FocusState private var focusedField: OnboardingInputField?
    
    init(viewModel: PhoneInputViewModel) {
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
extension PhoneOnboardingInputView {
    
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
            prompt: Text(viewModel.fieldTitle).foregroundColor(.tertiaryBackground)
        )
        .textFieldStyle(PhoneTextFieldStyle(phone: $viewModel.text))
        .focused($focusedField, equals: viewModel.field)
        .submitLabel(.next)
        .onTapGesture {
            focusedField = .phone
        }
    }
}

// MARK: - Preview
#Preview {
    let parentCoordinator = RootCoordinator()
    let coordinator = OnboardingCoordinator(parentCoordinator: parentCoordinator)
    let viewModel = PhoneInputViewModel(
        coordinator: coordinator,
        onboardingInput: .init()
    )
    return PhoneOnboardingInputView(viewModel: viewModel)
}
