//
//  DefaultTextFieldInputView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/13/24.
//

import SwiftUI

struct DefaultTextInputField<ViewModel: UserTextInputViewModel, Style: TextFieldStyle, Requirement: InputRequirement>: View {
    @Bindable var viewModel: ViewModel
    let textFieldStyle: Style
    
    init(
        viewModel: ViewModel,
        requirementType: Requirement.Type,
        textFieldStyle: Style
    ) {
        self.viewModel = viewModel
        self.textFieldStyle = textFieldStyle
    }
    
    var body: some View {
        TextField(
            viewModel.fieldTitle,
            text: $viewModel.text,
            prompt: Text(viewModel.fieldTitle).foregroundColor(.tertiaryBackground)
        )
        .requirements(
            text: $viewModel.text,
            requirementType: Requirement.self,
            field: viewModel.field
        )
        .textFieldStyle(textFieldStyle)
    }
}

// MARK: - Preview
#Preview {
    @FocusState var focusedField: CreateCommunityField?
    
    return ZStack {
        Color.primaryBackground.ignoresSafeArea()
        
        DefaultTextInputField(
            viewModel: CommunityNameViewModel.preview,
            requirementType: NoneRequirement.self,
            textFieldStyle: TitleTextFieldStyle(
                title: .constant("Community Title"),
                focusedField: $focusedField,
                field: CreateCommunityField.name
            ))
    }
}
