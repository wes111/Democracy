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
    @State private var size: CGSize = .zero
    
    init(viewModel: PostBodyViewModel) {
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
private extension PostBodyView {
    var field: some View {
        TextEditor(text: $viewModel.text)
            .defaultStyle(
                text: $viewModel.text,
                maxCharacterCount: viewModel.field.maxCharacterCount
            )
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
    let viewModel = PostBodyViewModel(
        coordinator: SubmitPostCoordinator.preview,
        submitPostInput: .init()
    )
    return PostBodyView(viewModel: viewModel)
}
