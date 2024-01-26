//
//  CommunityNameView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import SwiftUI

struct CommunityNameView: View {
    @Bindable var viewModel: CommunityNameViewModel
    @FocusState private var focusedField: CreateCommunityField?
    
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
            viewModel: viewModel,
            textFieldStyle: DefaultTrimmedTextFieldStyle(
                title: $viewModel.text,
                focusedField: $focusedField,
                field: .name
            ))
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityNameView(viewModel: .preview)
    }
}
