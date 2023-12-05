//
//  PhoneOnboardingInputView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/4/23.
//

import SwiftUI

struct PhoneOnboardingInputView: OnboardingInputView {
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
        .textFieldStyle(UsernameTextFieldStyle(username: $viewModel.text)) // TODO: Make Phone style.
        .focused($focusedField, equals: viewModel.field)
        .submitLabel(.next)
        .onTapGesture {
            focusedField = .phone
        }
    }
}

#Preview {
    let parentCoordinator = RootCoordinator()
    let coordinator = OnboardingCoordinator(parentCoordinator: parentCoordinator)
    let viewModel = PhoneInputViewModel(
        coordinator: coordinator,
        onboardingInput: .init()
    )
    return PhoneOnboardingInputView(viewModel: viewModel)
}
