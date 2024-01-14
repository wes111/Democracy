//
//  DefaultTextFieldInputView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/13/24.
//

import SwiftUI

struct DefaultTextFieldInputView<ViewModel: UserTextInputViewModel, Style: TextFieldStyle>: View {
    @ObservedObject var viewModel: ViewModel
    @FocusState.Binding var focusedField: ViewModel.Field?
    let textFieldStyle: Style
    let shouldOverrideOnAppear: Bool
    
    init(
        viewModel: ViewModel,
        focusedField: FocusState<ViewModel.Field?>.Binding,
        shouldOverrideOnAppear: Bool = false,
        textFieldStyle: Style
    ) {
        self.viewModel = viewModel
        self._focusedField = focusedField
        self.shouldOverrideOnAppear = shouldOverrideOnAppear
        self.textFieldStyle = textFieldStyle
    }
    
    var body: some View {
        UserTextInputView(
            viewModel: viewModel,
            focusedField: $focusedField,
            shouldOverrideOnAppear: shouldOverrideOnAppear
        ) {
            field
        }
    }
}

// MARK: Subviews
private extension DefaultTextFieldInputView {
    var field: some View {
        TextField(
            viewModel.fieldTitle,
            text: $viewModel.text,
            prompt: Text(viewModel.fieldTitle).foregroundColor(.tertiaryBackground)
        )
        .textFieldStyle(textFieldStyle)
        .requirements(text: viewModel.text, textErrors: viewModel.textErrors)
    }
}

// MARK: - Preview
//#Preview {
//    DefaultTextFieldInputView()
//}
