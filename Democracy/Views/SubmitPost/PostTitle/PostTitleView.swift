//
//  CreatePostTitleView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import SwiftUI

struct PostTitleView: View {
    @ObservedObject var viewModel: PostTitleViewModel
    @FocusState private var focusedField: SubmitPostField?
    
    init(viewModel: PostTitleViewModel) {
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
extension PostTitleView {
    
    var field: some View {
        TextField(
            "Title",
            text: $viewModel.text,
            prompt: Text("Title").foregroundColor(.tertiaryBackground)
        )
        .textFieldStyle(TitleTextFieldStyle(title: $viewModel.text))
        .requirements(
            text: viewModel.text,
            allPossibleErrors: viewModel.allErrors,
            textErrors: viewModel.textErrors
        )
        .focused($focusedField, equals: viewModel.field)
        .submitLabel(.next)
        .onTapGesture {
            focusedField = viewModel.field
        }
    }
}

// MARK: - Preview
#Preview {
    let viewModel = PostTitleViewModel(coordinator: SubmitPostCoordinator.preview)
    return PostTitleView(viewModel: viewModel)
}
