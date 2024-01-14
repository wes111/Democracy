//
//  CreatePostTitleView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import SwiftUI

struct PostTitleView<ViewModel: PostTitleViewModel>: View {
    @ObservedObject var viewModel: ViewModel
    @FocusState private var focusedField: SubmitPostField?
    
    var body: some View {
        DefaultTextFieldInputView(
            viewModel: viewModel,
            focusedField: $focusedField,
            textFieldStyle: TitleTextFieldStyle(
                title: $viewModel.text,
                focusedField: $focusedField,
                textErrors: viewModel.textErrors
            )
        )
    }
}

// MARK: - Preview
#Preview {
    let viewModel = PostTitleViewModel(coordinator: SubmitPostCoordinator.preview)
    return PostTitleView(viewModel: viewModel)
}
