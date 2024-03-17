//
//  CommunityNameView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 1/24/24.
//

import SwiftUI

@MainActor
struct CommunityNameView<ViewModel: CommunityNameViewModel>: View {
    @Bindable var viewModel: ViewModel
    @FocusState private var focusedField: ViewModel.FocusedField?
    
    var body: some View {
        primaryContent
            .onAppear {
                viewModel.onAppear()
            }
    }
}

// MARK: - Subviews
private extension CommunityNameView {
    
    var primaryContent: some View {
        SubmittableTextInputView(viewModel: viewModel, focusedField: $focusedField) {
            VStack {
                field
                Spacer()
                SubmittableNextButton(viewModel: viewModel)
            }
        }
    }
    
    var field: some View {
        DefaultTextInputField(
            text: $viewModel.text,
            textFieldStyle: DefaultTrimmedTextFieldStyle(
                title: $viewModel.text,
                focusedField: $focusedField,
                field: .name
            ),
            fieldTitle: viewModel.fieldTitle,
            requirementType: ViewModel.Requirement.self
        )
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        CommunityNameView(viewModel: .preview)
    }
}
