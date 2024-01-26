//
//  PostLinkView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import SwiftUI

struct PostPrimaryLinkView<ViewModel: PostPrimaryLinkViewModel>: View {
    @Bindable var viewModel: ViewModel
    @FocusState private var focusedField: SubmitPostField?
    
    var body: some View {
        UserTextInputView(
            viewModel: viewModel,
            focusedField: $focusedField) {
                field
            }
            .onAppear {
                viewModel.onAppear()
            }
    }
}

private extension PostPrimaryLinkView {
    var field: some View {
        DefaultTextInputField(
            viewModel: viewModel,
            textFieldStyle: LinkTextFieldStyle(
                link: $viewModel.text,
                focusedField: $focusedField,
                field: .primaryLink
            ))
    }
}

// MARK: - Preview
#Preview {
    let viewModel = PostPrimaryLinkViewModel(
        coordinator: SubmitPostCoordinator.preview,
        submitPostInput: .init()
    )
    return PostPrimaryLinkView(viewModel: viewModel)
}
