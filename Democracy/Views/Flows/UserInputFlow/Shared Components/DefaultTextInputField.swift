//
//  DefaultTextFieldInputView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/13/24.
//

import SwiftUI

struct DefaultTextInputField<ViewModel: UserTextInputViewModel, Style: TextFieldStyle>: View {
    @Bindable var viewModel: ViewModel
    let textFieldStyle: Style
    
    var body: some View {
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
#Preview {
    @FocusState var focusedField: CreateCommunityField?
    
    return ZStack {
        Color.primaryBackground.ignoresSafeArea()
        
        DefaultTextInputField(
            viewModel: CommunityNameViewModel.preview,
            textFieldStyle: TitleTextFieldStyle(
                title: .constant("Community Title"),
                focusedField: $focusedField,
                field: CreateCommunityField.name
            ))
    }
}
