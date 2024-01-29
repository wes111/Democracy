//
//  CommunityNameView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import SwiftUI

struct CommunityNameView: View {
    @Bindable var viewModel: CommunityNameViewModel
    @FocusState private var focusedField: CreateCommunityFlow?
    
    var body: some View {
        UserTextInputView(
            viewModel: viewModel,
            focusedField: $focusedField) {
                field
            }
    }
}

// MARK: - Subviews
private extension CommunityNameView {
    var field: some View {
        DefaultTextInputField(
            text: $viewModel.text,
            textFieldStyle: DefaultTrimmedTextFieldStyle(
                title: $viewModel.text,
                focusedField: $focusedField,
                field: .name
            ),
            fieldTitle: viewModel.fieldTitle,
            requirementType: CommunityNameViewModel.Requirement.self
        )
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityNameView(viewModel: .preview)
    }
}
