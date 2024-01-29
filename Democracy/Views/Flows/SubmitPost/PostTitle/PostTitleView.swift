//
//  CreatePostTitleView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import SwiftUI

struct PostTitleView<ViewModel: PostTitleViewModel>: View {
    @Bindable var viewModel: ViewModel
    @FocusState private var focusedField: SubmitPostFlow?
    
    var body: some View {
        UserTextInputView(
            viewModel: viewModel,
            focusedField: $focusedField) {
                field
            }
    }
}

private extension PostTitleView {
    var field: some View {
        DefaultTextInputField(
            text: $viewModel.text,
            textFieldStyle: TitleTextFieldStyle(
                title: $viewModel.text,
                focusedField: $focusedField,
                field: .title
            ),
            fieldTitle: viewModel.fieldTitle,
            requirementType: ViewModel.Requirement.self
        )
    }
}

// MARK: - Preview
#Preview {
    let viewModel = PostTitleViewModel(coordinator: SubmitPostCoordinator.preview)
    return NavigationStack {
        PostTitleView(viewModel: viewModel)
    }
}
