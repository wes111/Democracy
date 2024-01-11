//
//  PostLinkView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import SwiftUI

struct PostPrimaryLinkView: View {
    
    @ObservedObject var viewModel: PostPrimaryLinkViewModel
    @FocusState private var focusedField: SubmitPostField?
    
    init(viewModel: PostPrimaryLinkViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        UserTextInputView(
            viewModel: viewModel,
            content: { field }
        )
        .onAppear {
            focusedField = viewModel.field
            viewModel.onAppear()
        }
        .onTapGesture {
            focusedField = nil
        }
    }
}

// MARK: - Subviews
private extension PostPrimaryLinkView {
    var field: some View {
        TextField(
            "Primary Link",
            text: $viewModel.text,
            prompt: Text("Primary Link").foregroundColor(.tertiaryBackground)
        )
        .textFieldStyle(LinkTextFieldStyle(link: $viewModel.text))
        .focused($focusedField, equals: viewModel.field)
        .submitLabel(.next)
        .onTapGesture {
            focusedField = viewModel.field
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
