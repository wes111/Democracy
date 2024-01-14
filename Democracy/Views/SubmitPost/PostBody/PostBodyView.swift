//
//  PostTitleView.swift
//  Democracy
//
//  Created by Wesley Luntsford on 12/17/23.
//

import SwiftUI

struct PostBodyView: View {
    @ObservedObject var viewModel: PostBodyViewModel
    @FocusState private var focusedField: SubmitPostField?
    
    var body: some View {
        UserTextInputView(viewModel: viewModel, focusedField: $focusedField) {
            field
        }
    }
}

// MARK: - Subviews
private extension PostBodyView {
    var field: some View {
        TextEditor(text: $viewModel.text)
            .defaultStyle(
                input: PostBodyValidator.self,
                text: $viewModel.text,
                focusedField: $focusedField
            )
    }
}

// MARK: - Preview
#Preview {
    let viewModel = PostBodyViewModel(
        coordinator: SubmitPostCoordinator.preview,
        submitPostInput: .init()
    )
    return PostBodyView(viewModel: viewModel)
}
