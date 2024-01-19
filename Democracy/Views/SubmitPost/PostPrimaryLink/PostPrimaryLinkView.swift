//
//  PostLinkView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import SwiftUI

struct PostPrimaryLinkView<ViewModel: PostPrimaryLinkViewModel>: View {
    @ObservedObject var viewModel: ViewModel
    @FocusState private var focusedField: SubmitPostField?
    
    var body: some View {
        DefaultTextFieldInputView(
            viewModel: viewModel,
            focusedField: $focusedField,
            textFieldStyle: LinkTextFieldStyle(
                link: $viewModel.text,
                focusedField: $focusedField,
                field: .primaryLink
            )
        )
        .onAppear {
            viewModel.onAppear()
        }
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
