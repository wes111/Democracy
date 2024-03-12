//
//  PostLinkView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import SwiftUI

@MainActor
struct PostPrimaryLinkView<ViewModel: PostPrimaryLinkViewModel>: View {
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
private extension PostPrimaryLinkView {
    
    var primaryContent: some View {
        SubmittableTextInputView(viewModel: viewModel) {
            VStack {
                field
                Spacer()
                SubmittableNextAndSkipButtons(viewModel: viewModel)
            }
        }
    }
    
    var field: some View {
        DefaultTextInputField(
            text: $viewModel.text,
            textFieldStyle: LinkTextFieldStyle(
                link: $viewModel.text,
                focusedField: $focusedField,
                field: .primaryLink
            ),
            fieldTitle: viewModel.fieldTitle,
            requirementType: ViewModel.Requirement.self
        )
    }
}

// MARK: - Preview
#Preview {
    NavigationStack {
        PostPrimaryLinkView(viewModel: .preview)
    }
}
