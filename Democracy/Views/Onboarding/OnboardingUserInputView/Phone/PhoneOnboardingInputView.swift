//
//  PhoneOnboardingInputView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/4/23.
//

import SwiftUI

struct PhoneOnboardingInputView: View {
    @ObservedObject var viewModel: PhoneInputViewModel
    @FocusState private var focusedField: OnboardingInputField?
    
    init(viewModel: PhoneInputViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        UserTextInputView(
            viewModel: viewModel,
            content: { field }
        )
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
    let viewModel = PhoneInputViewModel(
        coordinator: OnboardingCoordinator.preview,
        onboardingInput: .init()
    )
    return PhoneOnboardingInputView(viewModel: viewModel)
}
