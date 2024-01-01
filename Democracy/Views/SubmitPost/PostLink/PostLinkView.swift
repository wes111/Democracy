//
//  PostLinkView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import SwiftUI

struct PostLinkView: View {
    
    @ObservedObject var viewModel: PostLinkViewModel
    @FocusState private var focusedField: SubmitPostField?
    
    init(viewModel: PostLinkViewModel) {
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
private extension PostLinkView {
    var field: some View {
        TextField(
            "Link",
            text: $viewModel.text,
            prompt: Text("Link").foregroundColor(.tertiaryBackground)
        )
        .textFieldStyle(TitleTextFieldStyle(title: $viewModel.text))
        .focused($focusedField, equals: viewModel.field)
        .submitLabel(.next)
        .onTapGesture {
            focusedField = viewModel.field
        }
    }
}

// MARK: - Preview
#Preview {
    let viewModel = PostLinkViewModel(
        coordinator: SubmitPostCoordinator.preview,
        submitPostInput: .init()
    )
    return PostLinkView(viewModel: viewModel)
}
