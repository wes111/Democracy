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
        DefaultTextFieldInputView(
            viewModel: viewModel,
            focusedField: $focusedField,
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
